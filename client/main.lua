local isOpen = false
local clothingState = {}
local originalClothing = {}
local cam = nil

Citizen.CreateThread(function()
    for i, _ in ipairs(Config.Clothing) do
        clothingState[i] = true
    end
end)

RegisterCommand(Config.Command, function()
    ToggleMenu()
end, false)

RegisterKeyMapping(Config.Command, 'Open Clothing Menu', 'keyboard', Config.DefaultKey)

function ToggleMenu()
    isOpen = not isOpen
    SetNuiFocus(isOpen, isOpen)
    local ped = PlayerPedId()
    if isOpen then
        if not DoesCamExist(cam) then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        end
        local coords = GetEntityCoords(ped)
        local forward = GetEntityForwardVector(ped)
        local camPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
        SetCamCoord(cam, camPos.x, camPos.y, camPos.z)
        PointCamAtCoord(cam, coords.x, coords.y, coords.z)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
        FreezeEntityPosition(ped, true)
        SendNUIMessage({
            type = "open",
            items = Config.Clothing,
            colors = Config.Colors,
            states = clothingState
        })
        Citizen.CreateThread(function()
            local updates = {}
            local lastUpdates = {}
            while isOpen do
                local hasChanged = false
                for i, item in ipairs(Config.Clothing) do
                    local x, y = 50, 50
                    if item.bone then
                        local boneCoords = GetPedBoneCoords(ped, item.bone.id, item.bone.offset.x, item.bone.offset.y, item.bone.offset.z)
                        local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(boneCoords.x, boneCoords.y, boneCoords.z)
                        x = screenX * 100
                        y = screenY * 100
                    else
                        x = item.x or 50
                        y = item.y or 50
                    end
                    updates[i] = { x = x, y = y }
                    if not lastUpdates[i] or math.abs(lastUpdates[i].x - x) > 0.1 or math.abs(lastUpdates[i].y - y) > 0.1 then
                        hasChanged = true
                        lastUpdates[i] = { x = x, y = y }
                    end
                end
                if hasChanged then
                    SendNUIMessage({
                        type = "updatePositions",
                        items = updates
                    })
                end
                Wait(100) 
            end
        end)
    else
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(cam, false)
        cam = nil
        FreezeEntityPosition(ped, false)
        ClearFocus()
        SendNUIMessage({
            type = "close"
        })
    end
end

RegisterNUICallback("close", function(data, cb)
    ToggleMenu()
    cb('ok')
end)

RegisterNUICallback("toggleItem", function(data, cb)
    local index = data.index + 1
    local item = Config.Clothing[index]
    if item then
        Citizen.CreateThread(function()
            ToggleClothingItem(index, item)
        end)
    end
    cb('ok')
end)

function ToggleClothingItem(index, item)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    local isMale = (model == GetHashKey("mp_m_freemode_01"))
    local genderStr = isMale and "male" or "female"
    local offDrawable = item.off_drawable[genderStr]
    local offTexture = item.off_texture[genderStr]
    if clothingState[index] then
        local currentDrawable = 0
        local currentTexture = 0
        if item.type == "component" then
            currentDrawable = GetPedDrawableVariation(ped, item.component)
        elseif item.type == "prop" then
            currentDrawable = GetPedPropIndex(ped, item.component)
        end
        if currentDrawable == offDrawable then
            SendNUIMessage({
                type = "notification",
                message = "You are not wearing this item."
            })
            return 
        end
    end

    clothingState[index] = not clothingState[index]
    SendNUIMessage({
        type = "updateState",
        states = clothingState
    })
    if item.anim then
        RequestAnimDict(item.anim.dict)
        local timeout = 0
        while not HasAnimDictLoaded(item.anim.dict) and timeout < 50 do
            Wait(10)
            timeout = timeout + 1
        end
        if HasAnimDictLoaded(item.anim.dict) then
            TaskPlayAnim(ped, item.anim.dict, item.anim.name, 8.0, 2.0, -1, 48, 2, 0, 0, 0)
            Wait(1000)
        end
    end

    if clothingState[index] then
        if item.type == "component" then
            local old = originalClothing[index]
            if old then
                SetPedComponentVariation(ped, item.component, old[1], old[2], 0)
            end
        elseif item.type == "prop" then
            local old = originalClothing[index]
            if old then
                if old[1] == -1 then
                    ClearPedProp(ped, item.component)
                else
                    SetPedPropIndex(ped, item.component, old[1], old[2], true)
                end
            end
        end
    else
        if item.type == "component" then
            originalClothing[index] = { GetPedDrawableVariation(ped, item.component), GetPedTextureVariation(ped, item.component) }
            SetPedComponentVariation(ped, item.component, offDrawable, offTexture, 0)
        elseif item.type == "prop" then
            originalClothing[index] = { GetPedPropIndex(ped, item.component), GetPedPropTextureIndex(ped, item.component) }
            if offDrawable == -1 then
                ClearPedProp(ped, item.component)
            else
                SetPedPropIndex(ped, item.component, offDrawable, offTexture, true)
            end
        end
    end
    Wait(500)
    if item.anim then
        StopAnimTask(ped, item.anim.dict, item.anim.name, 1.0)
    end
end