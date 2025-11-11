# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it by:

1. **DO NOT** open a public issue
2. Email the maintainer directly (or use GitHub Security Advisories)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We take security seriously and will respond as quickly as possible.

## Security Considerations

### Password Storage

This script uses **XOR obfuscation** for password storage, not encryption. Here's what you need to know:

#### ✅ What it protects against:
- Casual viewing of the credential file
- Accidental exposure in logs or screenshots
- Basic file searches for plaintext passwords

#### ⚠️ What it does NOT protect against:
- Determined attackers with file access
- Malware running under your user account
- Physical access to your unlocked computer

### Threat Model

This tool is designed for the following security context:

**Appropriate for:**
- Corporate VPN access on your work laptop
- Convenience vs. security trade-off similar to browser password managers
- Environments where physical security is already established

**NOT appropriate for:**
- Highly sensitive systems requiring 2FA/MFA
- Shared computers
- Systems handling classified information
- Environments where maximum security is required

### Best Practices

To use this tool securely:

1. **Keep your Windows account secure**
   - Use a strong Windows password
   - Enable BitLocker disk encryption
   - Lock your computer when away (Win+L)

2. **Protect the credential file**
   - Don't copy `vpn_credential.dat` to other machines
   - Don't commit it to version control (it's in .gitignore)
   - Don't share it with others

3. **Regular password rotation**
   - Follow your company's password policy
   - Update the saved password when you change it
   - Delete `vpn_credential.dat` to force re-entry

4. **Verify script integrity**
   - Only download from trusted sources
   - Review the code before running
   - Check for modifications if shared internally

## Known Limitations

### XOR Obfuscation
The password is obfuscated using simple XOR with a static key. This is **not cryptographic encryption** and can be reversed by anyone who has:
- Access to the credential file
- Access to the script code
- Basic programming knowledge

**Why we use it anyway:**
- Better than plaintext
- Sufficient for the intended use case
- No external dependencies required
- Works in restricted corporate environments

### File System Security
The credential file is stored in the same directory as the script with default Windows permissions. Anyone with access to your Windows user account can read it.

### No Transport Security
This script doesn't handle the VPN connection's transport security - that's managed by Cisco Secure Client itself.

## Compliance

**Before using this tool, ensure it complies with:**
- ✅ Your company's security policies
- ✅ Your organization's acceptable use policy
- ✅ Any industry-specific regulations (HIPAA, SOX, etc.)
- ✅ Your IT department's guidelines

When in doubt, ask your IT security team!

## Alternative: No Password Storage

If your security requirements don't allow password storage, you can still use this script! Simply:
1. Choose "No" when asked to save the password
2. Enter your password each time you run the script
3. Still saves you the clicking through the VPN GUI!

## Updates and Patches

- Watch this repository for security updates
- Enable GitHub notifications for this project
- Check for updates periodically

## Responsible Disclosure

If you find a security issue:
- Give us reasonable time to address it before public disclosure
- We aim to respond within 48 hours
- We'll credit you in the fix (unless you prefer anonymity)

## Questions?

If you have security questions or concerns, please open a discussion or issue (for non-sensitive topics) or contact the maintainers directly (for sensitive topics).

---

**Remember**: This tool is about convenience, not maximum security. Use it responsibly!