local function bone(id, x, y, z)
    return { id = id, offset = vector3(x, y, z) }
end

local function withOff(data, maleDrawable, femaleDrawable, maleTexture, femaleTexture)
    data.off_drawable = { male = maleDrawable, female = femaleDrawable }
    data.off_texture = { male = maleTexture or 0, female = femaleTexture or maleTexture or 0 }
    return data
end

Config = {
    command = 'clothingmenu',
    defaultKey = 'F9',

    -- Framework: 'auto' | 'qbx' | 'qbcore' | 'esx' | 'standalone'
    -- 'auto' detects: QBX > QBCore > ESX (es_extended/esx-legacy) > Standalone
    framework = 'auto',

    -- Item system: true = remove→inventory→wear, false = free toggle on/off
    itemSystem = false,

    ui = {
        colors = {
            primary = '#00ff88',
            secondary = 'rgba(0, 14, 22, 0.5)',
            accent = '#00d4ff',
            text = '#e8f6ff',
            danger = '#ff4d6d'
        }
    },

    performance = {
        positionWait = 0,
        positionThreshold = 0.03
    },

    cursor = {
        command = 'clothingcursor',
        key = 'LMENU',
        notify = true
    },

    progress = {
        removeDuration = 1500,
        wearDuration = 1200,
        removeLabel = 'Removing clothing...',
        targetRemoveLabel = 'Removing target clothing...',
        wearLabel = 'Putting clothing on...',
        canCancel = true,
        disable = { car = true, combat = true },
        wearAnim = { dict = 'clothingshirt', name = 'try_shirt_positive_d', flag = 49 },
        targetRemoveAnim = { dict = 'pickup_object', name = 'pickup_low' }
    },

    target = {
        enabled = true,
        testingMode = true,
        allowDead = true,
        allowHandcuffed = true,
        interactionDistance = 2.5,
        maxDistance = 5.0,
        icon = 'fa-solid fa-shirt',
        label = 'Remove Clothing'
    },

    emptyDrawables = {
        prop = {
            Glasses = { [0] = true },
            Watch = { [0] = true }
        },
        component = {
            Mask = { [0] = true },
            Bag = { [0] = true },
            Vest = { [0] = true },
            Necklace = { [0] = true }
        }
    },

    -- Appearance sync functions
    -- Default: illenium-appearance exports
    -- Customize for your clothing script (see examples below)
    sync = {
        getAppearance = function(ped)
            if GetResourceState('illenium-appearance') == 'started' then
                return exports['illenium-appearance']:getPedAppearance(ped)
            end
            -- Fallback: native functions
            local appearance = {}
            for i = 0, 11 do
                appearance['component_' .. i] = {
                    drawable = GetPedDrawableVariation(ped, i),
                    texture = GetPedTextureVariation(ped, i)
                }
            end
            for i = 0, 7 do
                appearance['prop_' .. i] = {
                    drawable = GetPedPropIndex(ped, i),
                    texture = GetPedPropTextureIndex(ped, i)
                }
            end
            return appearance
        end,

        applyAppearance = function(ped, appearance)
            if GetResourceState('illenium-appearance') == 'started' then
                exports['illenium-appearance']:setPedAppearance(ped, appearance)
                return
            end
            -- Fallback: native functions
            for k, v in pairs(appearance) do
                local typ, index = k:match('^(%w+)_(%d+)$')
                index = tonumber(index)
                if typ == 'component' then
                    SetPedComponentVariation(ped, index, v.drawable, v.texture, 0)
                elseif typ == 'prop' then
                    if v.drawable == -1 then
                        ClearPedProp(ped, index)
                    else
                        SetPedPropIndex(ped, index, v.drawable, v.texture, true)
                    end
                end
            end
        end,

        saveAppearance = function(appearance)
            if GetResourceState('illenium-appearance') == 'started' then
                TriggerServerEvent('illenium-appearance:server:saveAppearance', appearance)
            end
        end
    },

    clothing = {
        withOff({
            label = 'Mask',
            icon = 'entypo:mask',
            component = 1,
            type = 'component',
            itemName = 'clothing_mask',
            bone = bone(31086, 0.10, 0.05, -0.22),
            size = 50,
            anim = { dict = 'mp_masks@on_foot', name = 'put_on_mask' },
            removeAnim = { dict = 'mp_masks@on_foot', name = 'take_off_mask' }
        }, 0, 0),
        withOff({
            label = 'Hat',
            icon = 'fa6-solid:hat-cowboy',
            component = 0,
            type = 'prop',
            itemName = 'clothing_hat',
            bone = bone(31086, 0.38, 0.0, 0.0),
            size = 50,
            anim = { dict = 'clothingshirt', name = 'try_shirt_positive_d' },
            removeAnim = { dict = 'clothingshirt', name = 'try_shirt_positive_d' }
        }, -1, -1),
        withOff({
            label = 'Glasses',
            icon = 'mdi:glasses',
            component = 1,
            type = 'prop',
            itemName = 'clothing_glasses',
            bone = bone(31086, 0.10, 0.05, 0.22),
            size = 50,
            anim = { dict = 'clothingspecs', name = 'take_off' }
        }, -1, -1),
        withOff({
            label = 'Jacket',
            icon = 'ion:shirt',
            component = 11,
            type = 'component',
            itemName = 'clothing_jacket',
            bone = bone(24817, 0.0, 0.25, 0.0),
            anim = { dict = 'clothingtie', name = 'try_tie_neutral_a' }
        }, 15, 15),
        withOff({
            label = 'Pants',
            icon = 'ph:pants-fill',
            component = 4,
            type = 'component',
            itemName = 'clothing_pants',
            bone = bone(11816, 0.0, 0.25, 0.0),
            anim = { dict = 're@construction', name = 'out_of_breath' }
        }, 21, 15),
        withOff({
            label = 'Shoes',
            icon = 'mingcute:shoe-fill',
            component = 6,
            type = 'component',
            itemName = 'clothing_shoes',
            bone = bone(14201, 0.0, 0.1, 0.0),
            anim = { dict = 'random@domestic', name = 'pickup_low' }
        }, 34, 35),
        withOff({
            label = 'Bag',
            icon = 'bxs:backpack',
            component = 5,
            type = 'component',
            itemName = 'clothing_bag',
            bone = bone(24817, 0.0, 0.1, -0.25),
            anim = { dict = 'anim@heists@ornate_bank@grab_cash', name = 'grab_block' }
        }, 0, 0),
        withOff({
            label = 'Vest',
            icon = 'mingcute:vest-fill',
            component = 9,
            type = 'component',
            itemName = 'clothing_vest',
            bone = bone(24818, 0.0, 0.1, 0.25),
            anim = { dict = 'clothingtie', name = 'try_tie_neutral_a' }
        }, 0, 0),
        withOff({
            label = 'Watch',
            icon = 'mingcute:watch-fill',
            component = 6,
            type = 'prop',
            itemName = 'clothing_watch',
            bone = bone(18905, 0.05, 0.05, 0.0),
            anim = { dict = 'nmt_3_rcm-10', name = 'p_watch_01_s' }
        }, -1, -1),
        withOff({
            label = 'Necklace',
            icon = 'mdi:necklace',
            component = 7,
            type = 'component',
            itemName = 'clothing_necklace',
            bone = bone(39317, 0.0, 0.1, 0.0),
            size = 50,
            anim = { dict = 'clothingtie', name = 'try_tie_neutral_a' }
        }, 0, 0)
    }
}

-- Compatibility aliases for existing client/server code and third-party snippets.
Config.Command = Config.command
Config.DefaultKey = Config.defaultKey
Config.Colors = Config.ui.colors
Config.Clothing = Config.clothing
Config.EmptyDrawables = Config.emptyDrawables
Config.Performance = Config.performance
Config.Cursor = Config.cursor
Config.CursorCommand = Config.cursor.command
Config.CursorKey = Config.cursor.key
Config.Progress = Config.progress
Config.EnableTargetPlayer = Config.target.enabled
Config.TestingMode = Config.target.testingMode
Config.AllowDead = Config.target.allowDead
Config.AllowHandcuffed = Config.target.allowHandcuffed
Config.TargetDistance = Config.target.interactionDistance
Config.MaxTargetDistance = Config.target.maxDistance
Config.TargetIcon = Config.target.icon
Config.TargetLabel = Config.target.label
Config.ItemSystem = Config.itemSystem
Config.Sync = Config.sync
