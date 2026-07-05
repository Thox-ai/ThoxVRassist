<!-- thox-badges -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square&labelColor=09090b)](LICENSE)
[![THOX.ai Portfolio](https://img.shields.io/badge/THOX.ai%20portfolio-View%20Project-blue?style=flat-square&labelColor=09090b&logoColor=white)](https://thox.ai)
[![Status: active](https://img.shields.io/badge/status-active-green?style=flat-square&labelColor=09090b)](https://github.com/thox-ai/thox-ai)
[![Latest Release](https://img.shields.io/github/v/release/thox-ai/thox-ai?style=flat-square&labelColor=09090b&logo=github)](https://github.com/thox-ai/thox-ai/releases)
[![Last Commit](https://img.shields.io/github/last-commit/thox-ai/thox-ai?style=flat-square&labelColor=09090b)](https://github.com/thox-ai/thox-ai/commits/main)
[![Open Issues](https://img.shields.io/github/issues/thox-ai/thox-ai?style=flat-square&labelColor=09090b)](https://github.com/thox-ai/thox-ai/issues)
<!-- /thox-badges -->

# Contributing to THOX.ai Quest 3 Prototyping Assistant

Thank you for your interest in contributing to the THOX.ai Quest 3 Prototyping Assistant! This document outlines the guidelines and processes for contributing to this project.

## Code of Conduct

Please note that all contributors are expected to abide by the THOX.ai Code of Conduct. Be respectful and collaborative when reviewing code and issues.

## How to Contribute

There are many ways to contribute, beyond writing code. Here are some suggestions for what we're always looking for help with, in order of increasing difficulty:

### Reporting Bugs

This is the easiest way to contribute to the project. If you find a bug, please create an issue with the following information:

- A clear and descriptive title
- Steps to reproduce the bug
- Expected behavior vs. actual behavior
- Any relevant logs or screenshots
- Your environment (Quest 3 firmware version, browser version, etc.)

### Suggesting Enhancements

We're always looking for ways to improve the product. If you have an idea for a new feature or enhancement, please create an issue describing it. Include:

- A clear and descriptive title
- Why this enhancement would be valuable
- Any relevant examples or mockups
- Potential implementation considerations

### Code Contributions

If you'd like to contribute code, please follow these guidelines:

1. Fork the repository and create a feature branch:
   ```
   git checkout -b feature/my-feature
   ```

2. Make your changes, following the existing code style

3. Add tests for your changes (see Testing section below)

4. Ensure all tests pass:
   ```
   npm test
   ```

5. Run the linter to check code quality:
   ```
   npm run lint
   ```

6. Update documentation as needed

7. Commit your changes with a clear and concise commit message:
   ```
   git commit -m "feat: add feature description"
   ```

8. Push your branch to GitHub:
   ```
   git push origin feature/my-feature
   ```

9. Open a Pull Request on GitHub with a clear description of your changes

### Code Style

Please follow these code style guidelines:

- Use 2-space indentation
- Follow the existing naming conventions
- Keep functions and methods focused on a single responsibility
- Add comments to complex code sections
- Use meaningful variable and function names

## Testing

Before submitting your code, please ensure that all existing tests pass and add new tests for any new functionality. Run the test suite with:

```
npm test
```

## Documentation

Good documentation is essential for a maintainable codebase. When submitting code, please ensure that:

- All public functions and classes have JSDoc comments
- README documentation is up to date
- Inline comments explain non-obvious code
- Complex algorithms are documented

## Pull Request Guidelines

When submitting a Pull Request, please include:

1. A clear and descriptive title
2. A detailed description of the changes
3. Any relevant issue numbers
4. Screenshots or videos demonstrating the changes (for UI modifications)
5. Information about breaking changes

## Questions?

If you have any questions about contributing, please don't hesitate to reach out or create an issue.

Thank you for contributing to THOX.ai Quest 3 Prototyping Assistant!
