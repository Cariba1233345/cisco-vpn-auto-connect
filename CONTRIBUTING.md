# Contributing to Cisco VPN Auto-Connect

First off, thanks for taking the time to contribute! 🎉

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates.

When creating a bug report, include:
- **OS Version**: Windows 10/11 version
- **Cisco Secure Client Version**: e.g., 5.1.7.80
- **Steps to reproduce**: Detailed steps
- **Expected behavior**: What you expected to happen
- **Actual behavior**: What actually happened
- **Error messages**: Any error dialogs or messages

### 💡 Suggesting Enhancements

Enhancement suggestions are welcome! Please include:
- **Clear description**: What feature you'd like to see
- **Use case**: Why this feature would be useful
- **Examples**: How it would work in practice

### 🔧 Pull Requests

1. **Fork the repository**
2. **Create a branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Test thoroughly**: Ensure it works on your system
5. **Commit**: `git commit -m 'Add amazing feature'`
6. **Push**: `git push origin feature/amazing-feature`
7. **Open a Pull Request**

#### Pull Request Guidelines

- Keep changes focused (one feature/fix per PR)
- Update README.md if needed
- Test on Windows 10 and/or Windows 11
- Follow the existing code style
- Add comments for complex logic
- Ensure backwards compatibility when possible

## Code Style

- Use clear, descriptive variable names
- Add comments for non-obvious code
- Keep functions focused and small
- Use constants for configuration values

## Testing

Before submitting:
- ✅ Test fresh installation (no saved password)
- ✅ Test with saved password
- ✅ Test wrong password handling
- ✅ Test when already connected
- ✅ Verify credential file is created/deleted properly

## Security Considerations

When contributing, keep in mind:
- Never commit actual credentials or credential files
- Don't weaken the password obfuscation
- Consider corporate security policies
- Document any security implications of changes

## Questions?

Feel free to open an issue with the `question` label!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.