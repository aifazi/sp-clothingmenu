Config = {}

-- [[ GENERAL SETTINGS ]] --

-- Command to open the clothing menu.
-- Usage: /clothingmenu
Config.Command = "clothingmenu"

-- Default keybind to open the menu.
-- Players can customize this in their FiveM Key Bindings settings.
Config.DefaultKey = "K" 

-- Color palette for the Menu UI.
-- Uses Hex Codes.
Config.Colors = {
    primary = "#a855f7",   -- Active element color (Hexagons & Borders)
    secondary = "#0f0c29", -- Background color (Dark & Transparent)
    accent = "#d8b4fe",    -- Accent color for hover states
    text = "#ffffff"       -- Main text color
}

-- [[ CLOTHING ITEMS ]] --

-- Define the interactive clothing items here.
-- Each item tracks a specific body part (Bone) for the 3D 'Floating UI' effect.

-- COMPONENT IDs REFERENCE:
-- 1: Mask | 3: Torso (Arms) | 4: Legs (Pants) | 5: Bags/Parachute 
-- 6: Shoes | 7: Accessories (Necklace) | 8: Undershirt | 9: Body Armor (Vest) 
-- 11: Tops (Jackets/Shirts)

-- PROP IDs REFERENCE:
-- 0: Hats | 1: Glasses | 2: Ears | 6: Watches | 7: Bracelets

Config.Clothing = {
    {
        label = "Mask",          -- Display Name in Menu
        icon = "entypo:mask",    -- Iconify ID (https://icon-sets.iconify.design/)
        component = 1,           -- GTA Component ID
        type = "component",      -- Item Type: 'component' or 'prop'
        bone = { id = 31086, offset = vector3(0.10, 0.05, -0.22) }, -- 3D Position relative to bone
        size = 50,               -- Icon Size
        off_drawable = { male = 0, female = 0 }, -- ID to set when item is toggled OFF
        off_texture = { male = 0, female = 0 }, -- ID to set when item texture is toggled OFF
        anim = { dict = "mp_masks@on_foot", name = "put_on_mask" } -- Animation
    },
    {
        label = "Hat",
        icon = "fa6-solid:hat-cowboy",
        component = 0,
        type = "prop",
        bone = { id = 31086, offset = vector3(0.38, 0.0, 0.0) },
        size = 50,
        off_drawable = { male = -1, female = -1 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "missheistdfo1ls_9", name = "p_head_hab_s" }
    },
    {
        label = "Glasses",
        icon = "mdi:glasses", 
        component = 1,
        type = "prop",
        bone = { id = 31086, offset = vector3(0.10, 0.05, 0.22) },
        size = 50,
        off_drawable = { male = -1, female = -1 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "clothingspecs", name = "take_off" }
    },
    {
        label = "Jacket",
        icon = "ion:shirt",
        component = 11,
        type = "component",
        bone = { id = 24817, offset = vector3(0.0, 0.25, 0.0) },
        off_drawable = { male = 15, female = 15 },         
        off_texture = { male = 0, female = 0 },
        anim = { dict = "clothingtie", name = "try_tie_neutral_a" }
    },
    {
        label = "Pants",
        icon = "ph:pants-fill",
        component = 4,
        type = "component",
        bone = { id = 11816, offset = vector3(0.0, 0.25, 0.0) },
        off_drawable = { male = 21, female = 15 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "re@construction", name = "out_of_breath" }
    },
    {
        label = "Shoes",
        icon = "mingcute:shoe-fill",
        component = 6,
        type = "component",
        bone = { id = 14201, offset = vector3(0.0, 0.1, 0.0) },
        off_drawable = { male = 34, female = 35 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "random@domestic", name = "pickup_low" }
    },
    {
        label = "Bag",
        icon = "bxs:backpack",
        component = 5,
        type = "component",
        bone = { id = 24817, offset = vector3(0.0, 0.1, -0.25) },
        off_drawable = { male = 0, female = 0 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "anim@heists@ornate_bank@grab_cash", name = "grab_block" }
    },
    {
        label = "Vest",
        icon = "mingcute:vest-fill",
        component = 9,
        type = "component",
        bone = { id = 24818, offset = vector3(0.0, 0.1, 0.25) },
        off_drawable = { male = 0, female = 0 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "clothingtie", name = "try_tie_neutral_a" }
    },
    {
        label = "Watch",
        icon = "mingcute:watch-fill",
        component = 6,
        type = "prop",
        bone = { id = 18905, offset = vector3(0.05, 0.05, 0.0) },
        off_drawable = { male = -1, female = -1 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "nmt_3_rcm-10", name = "p_watch_01_s" }
    },
    {
        label = "Necklace",
        icon = "mdi:necklace",
        component = 7,
        type = "component",
        bone = { id = 39317, offset = vector3(0.0, 0.1, 0.0) },
        size = 50,
        off_drawable = { male = 0, female = 0 },
        off_texture = { male = 0, female = 0 },
        anim = { dict = "clothingtie", name = "try_tie_neutral_a" }
    }
}