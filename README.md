# Mac-Style Hotkeys for Windows 11

Transform your Windows 11 experience with familiar Mac keyboard shortcuts. This AutoHotkey script remaps Windows hotkeys to match macOS behavior, making it seamless to switch between operating systems.

## Why This Exists

As someone who frequently switches between Mac and Windows, I found myself constantly hitting the wrong key combinations. This script bridges that gap by mapping the Windows key (⊞) to function like the Mac Command key (⌘), along with other Mac-style behaviors.

## Features

### 🎯 Essential Mac-Style Shortcuts
- **⊞ + C/X/V** → Copy, Cut, Paste
- **⊞ + A** → Select All  
- **⊞ + Z** → Undo
- **⊞ + ⇧ + Z** → Redo
- **⊞ + S** → Save
- **⊞ + F** → Find

### 🌐 Browser & Application Controls
- **⊞ + T** → New Tab
- **⊞ + ⇧ + T** → Reopen Closed Tab
- **⊞ + W** → Close Tab
- **⊞ + Q** → Quit Application
- **⊞ + R** → Refresh
- **⊞ + ⇧ + N** → New Incognito Window

### 🧭 Navigation & Text Editing
- **⊞ + ←/→** → Move to beginning/end of line
- **⌥ + ←/→** → Move by word
- **⌃ + ←/→** → Switch between virtual desktops

### 🚀 System Controls
- **⊞ + Space** → Open Start Menu (like Spotlight)
- **⊞ + Tab** → App Switcher (with persistent switcher when held)
- **⊞ + ⌃ + ⇧ + 4** → Screenshot tool
- **⊞ + ⇧ + 5** → Run dialog

### 🪟 Window Management
- **⊞ + ⌥ + 1/2/3** → Snap window to left/center/right third of screen

## Getting Started

### Prerequisites
- Windows 11 (may work on Windows 10)
- [AutoHotkey v2.0](https://www.autohotkey.com/) installed

### Installation

1. **Install AutoHotkey v2.0**
   - Download from [autohotkey.com](https://www.autohotkey.com/)
   - Run the installer and follow the setup wizard

2. **Download this script**
   ```bash
   git clone https://github.com/your-username/autohotkey-mac-shortcuts.git
   cd autohotkey-mac-shortcuts
   ```

3. **Run the script**
   - Double-click `main.ahk` to run
   - You should see the AutoHotkey icon in your system tray

4. **Start on boot (optional)**
   - Right-click `main.ahk` → "Create shortcut"
   - Move the shortcut to your Windows Startup folder:
     - Press `⊞ + R`, type `shell:startup`, press Enter
     - Paste the shortcut into this folder

### Usage

Once running, all hotkeys work immediately. Try pressing `⊞ + C` to copy text, or `⊞ + Space` to open the Start menu. The script runs silently in the background.

To stop the script, right-click the AutoHotkey icon in your system tray and select "Exit".

## Customization

Feel free to modify `main.ahk` to add your own shortcuts or adjust existing ones. The script is well-commented and organized into logical sections:

- **Mac-Style Hotkeys** - Core copy/paste/undo functionality
- **Screenshot & System Hotkeys** - System-level shortcuts  
- **Window Management** - Window snapping and organization
- **Navigation** - Text cursor and desktop switching

## Contributing

Contributions are welcome. Whether you want to:
- 🐛 Report bugs or issues
- ✨ Suggest new Mac shortcuts to implement
- 🔧 Submit improvements or optimizations
- 📚 Improve documentation

### How to Contribute

1. **For bug reports**: [Open an issue](../../issues/new) with:
   - Your Windows version
   - AutoHotkey version
   - Steps to reproduce the problem
   - Expected vs actual behavior

2. **For feature requests**: [Open an issue](../../issues/new) describing:
   - The Mac shortcut you'd like to see added
   - What it should do on Windows
   - Why it would be useful

3. **For code contributions**:
   - Fork this repository
   - Create a feature branch (`git checkout -b feature/new-shortcut`)
   - Test your changes thoroughly
   - Submit a pull request with a clear description

### Development Guidelines

- Keep the code well-commented
- Test shortcuts across different applications
- Follow the existing code organization
- Use AutoHotkey v2.0 syntax

## Troubleshooting

**Script not working?**
- Ensure AutoHotkey v2.0 is installed (not v1.1)
- Run AutoHotkey as administrator if needed
- Check that no other keyboard remapping software is conflicting

**Specific shortcut not working?**
- Some applications override global hotkeys
- Try the shortcut in different applications (Notepad, browsers, etc.)

**Performance issues?**
- The script is lightweight, but you can disable unused sections if needed

## License

This project is open source. Feel free to use, modify, and distribute as needed.

---

**Happy computing.**

*Now you can enjoy the best of both worlds - Mac muscle memory on Windows hardware.*
