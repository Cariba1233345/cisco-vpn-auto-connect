# 🚀 Cisco Secure Client VPN Auto-Connect

A simple, lightweight VBScript to automate your Cisco Secure Client VPN connection on Windows. Say goodbye to repetitive clicking and typing!

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows](https://img.shields.io/badge/Platform-Windows%2011%2F10-blue.svg)](https://www.microsoft.com/windows)
[![Cisco](https://img.shields.io/badge/Cisco%20Secure%20Client-5.1.7.80-green.svg)](https://www.cisco.com/)

## ✨ Features

- 🔐 **Secure password storage** - Uses XOR obfuscation (not plaintext!)
- 🖱️ **One-click connection** - Just double-click the script
- 💾 **Save password once** - Never type it again (optional)
- 🪟 **Native Windows** - No Python, no PowerShell policies, no installations
- 🎯 **Smart detection** - Checks if already connected before attempting
- 🛡️ **Corporate-friendly** - Works even in restricted environments
- 📦 **Lightweight** - Just one small VBScript file

## 🎬 Demo

**Before**: 7 steps, 30+ seconds
1. Open Cisco Secure Client
2. Clear the text box
3. Type VPN address
4. Click OK
5. Select Group
6. Enter username
7. Enter password

**After**: 1 step, 5 seconds
1. Double-click `double-clic-vpn.vbs` ✨

## 📋 Requirements

- Windows 10 or Windows 11
- Cisco Secure Client installed (tested on version 5.1.7.80)
- VPN credentials (host, group, username, password)

## 🚀 Quick Start

### 1. Download the Script

Download `double-clic-vpn.vbs` from this repository or copy the code into a new file.

### 2. Configure Your Settings

Open `double-clic-vpn.vbs` in a text editor and modify these lines (9-11):

```vbscript
Const VPN_HOST = "your-vpn.company.com"  ' Your VPN server address
Const VPN_GROUP = "YourGroup"            ' Your VPN group name
Const VPN_USERNAME = "your.username"     ' Your VPN username
```

### 3. Run It!

Double-click `double-clic-vpn.vbs`

- **First time**: Enter your password when prompted
  - Choose "Yes" to save it for future use (recommended)
  - Choose "No" if you prefer to enter it each time

- **Next times**: Just double-click and you're connected! 🎉

## 🎨 Pro Tips

### Easy shortcut
1. Create a shortcut to Desktop
2. Right-click shortcut
3. In Target field, write ```wscript "double-clic-vpn.vbs"```
4. Right-click the shortcut → **Properties**
5. Click **Change Icon**
6. Drag shortcut to taskbar for maximum convenience.
7. Browse to: `C:\Program Files (x86)\Cisco\Cisco Secure Client\`
8. Select a Cisco icon

Now you have a professional-looking VPN shortcut! You can also pin it to your taskbar.

### Add to Startup (Optional)

To auto-connect when Windows starts:
1. Press `Win + R`
2. Type `shell:startup` and press Enter
3. Copy your `double-clic-vpn.vbs` (or shortcut) to this folder

## 🔒 Security

### How is the password stored?

The password is **XOR-obfuscated** and stored in `vpn_credential.dat` in the same folder as the script.

- ✅ **Not plaintext** - Can't be read by opening the file
- ✅ **Tied to your machine** - File location matters
- ⚠️ **Not military-grade encryption** - Provides reasonable protection for this use case

### Is this secure enough?

**For corporate VPN on your work laptop: Yes.**

Consider this:
- If someone has access to your Windows account, they already have access to everything
- This is more secure than browser-saved passwords (which use similar techniques)
- The alternative (typing password 5+ times daily) doesn't improve security

**If you need maximum security**: Don't save the password. The script will prompt you each time.

## 🛠️ Troubleshooting

### "vpncli.exe not found"

**Solution**: The script looks for Cisco Secure Client in the default location:
```
C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe
```

If installed elsewhere, edit line 13 in the script:
```vbscript
Const VPNCLI_PATH = "C:\Your\Custom\Path\vpncli.exe"
```

### Connection fails with saved password

The script will automatically prompt you to enter a new password. Your old saved password will be replaced.

### "Connection failed" error

**Possible causes**:
- Wrong VPN host, group, or username in configuration
- Incorrect password
- VPN server is down
- Network connectivity issues

**Solution**: Double-check your configuration values and try running the official Cisco Secure Client manually to verify your credentials.

### Want to reset saved password

Simply delete the `vpn_credential.dat` file in the same folder as the script. Next run will ask for password again.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- 🐛 Report bugs
- 💡 Suggest new features
- 🔧 Submit pull requests
- ⭐ Star this repo if it helped you!

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This script is provided "as is" without warranty of any kind. Use at your own risk. This is an unofficial tool and is not affiliated with or endorsed by Cisco Systems, Inc.

Always comply with your company's security policies and acceptable use guidelines.

## 🙏 Acknowledgments

Created out of frustration with clicking through VPN dialogs 5 times a day. Hope it saves you time too!

---

**Made with ❤️ by someone who was tired of clicking**

If this saved you time, consider giving it a ⭐!