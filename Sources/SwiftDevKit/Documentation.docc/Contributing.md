# Contributing to SwiftDevKit

Learn how to contribute to SwiftDevKit's development.

## Overview

We welcome contributions to SwiftDevKit! This guide will help you understand our development process and how you can contribute effectively.

## Getting Started

1. Fork the repository
2. Clone your fork
3. Create a new branch
4. Make your changes
5. Submit a pull request

## Development Requirements

- Xcode 16.0+
- Swift 5.9+
- SwiftLint
- SwiftFormat
- SwiftGen

## Development Workflow

### Setting Up

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/SwiftDevKit.git
cd SwiftDevKit

# Install development tools
brew install swiftlint swiftformat swiftgen
```

### Making Changes

1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes following our guidelines
3. Run the test suite:
   ```bash
   swift test
   ```

4. Commit your changes using semantic commit messages:
   ```bash
   git commit -m "feat: Add new utility function"
   ```

### Code Style

- Follow Swift API Design Guidelines
- Use SwiftFormat for consistent formatting
- Adhere to SwiftLint rules
- Write comprehensive documentation

### Testing

- Write tests for new features
- Update existing tests when needed
- Include performance tests for critical paths
- Ensure all tests pass locally

### Documentation

- Use DocC syntax for documentation
- Include code examples
- Document all public APIs
- Update relevant guides

## Pull Request Process

1. Update documentation
2. Add tests
3. Update CHANGELOG.md
4. Submit PR with clear description
5. Address review feedback

## Community

- Be respectful and inclusive
- Follow our Code of Conduct
- Help others
- Share knowledge

## Additional Resources

- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [DocC Documentation](https://developer.apple.com/documentation/docc)
- [Swift Testing Documentation](https://github.com/apple/swift-testing) 