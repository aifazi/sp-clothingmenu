# 👕 Advanced 3D Clothing Menu (sp-clothingmenu)

A modern, immersive, and standalone clothing interaction menu for FiveM.
Unlike traditional list-based menus, this script projects a **3D Floating UI** directly onto the player's character. Icons are anchored to specific body parts (bones), creating a futuristic and intuitive experience for toggling clothing items.

## ✨ Features

- **3D Floating Interface**: Menu items track the character's body parts in real-time (Head, Torso, Legs, Feet, etc.).
- **Smart Toggling**: Put on or take off items like Masks, Hats, Glasses, Vests, and Bags with a single click.
- **Immersive Animations**: Plays realistic animations when equipping or unequip items.
- **Gender Auto-Detect**: Automatically detects Male/Female characters and applies the correct clothing variations.
- **Fully Configurable**: Easily customize items, icons, bone positions, colors, and default keybinds in `config.lua`.
- **Modern UI**: Sleek design with glassmorphism, hover effects, and smooth transitions.
- **Optimized**: 0.02ms idle time. The 3D coordinate calculation only runs when the menu is active.

## 📦 Installation

1. Download the repository.
2. Place the `sp-clothingmenu` folder into your server's `resources` directory.
3. Add the following line to your `server.cfg`:
   ```cfg
   ensure sp-clothingmenu
   ```
4. Restart your server or run `/refresh` and `/ensure sp-clothingmenu`.

## ⚙️ Configuration

You can customize almost everything in `config.lua`:

- **General**: Change the command name and default keybind.
- **Colors**: Adjust the UI color palette (Primary, Secondary, Accent).
- **Items**: Add or modify clothing slots. Each item allows you to define:
    - `icon`: Iconify ID for the UI.
    - `bone`: The body part the icon should track.
    - `anim`: The animation to play upon interaction.
    - `off_drawable`: What the character wears when the item is removed (e.g., bare feet or empty slot).

## 🎮 Usage

- **Command**: `/clothingmenu` (Default)
- **Keybind**: `K` (Default, configurable)
- **Interacting**: Use your mouse to click the floating icons.

## 🛠Dependencies

- None! This script is **Standalone** (works with ESX, QBCore, vMenu, or no framework).
