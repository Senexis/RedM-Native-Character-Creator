# Contributing to Native Character Creator
Thank you for considering contributing to Native Character Creator! This document outlines some basic information to help you get started with contributing.

## Getting Started
To contribute, you'll need to have Git installed on your machine. You can download and install Git from here.

To start contributing, you can follow these steps:

1. Fork the repository by clicking the ["Fork" button](https://github.com/Senexis/RedM-Native-Character-Creator/fork) on the top-right corner of the GitHub page.
2. Clone the repository to your local machine using the following command in your terminal or command prompt:

```bash
git clone https://github.com/your-username/RedM-Native-Character-Creator.git
```

3. Create a new branch for your changes using the following command:

```bash
git checkout -b your-branch-name
```

4. Make your changes and commit them using the following commands:

```bash
git add .
git commit -m "Add your commit message here"
```

5. Push your changes to your forked repository using the following command:

```bash
git push origin your-branch-name
```

6. Create a pull request by visiting the original repository and clicking the "New pull request" button.

## Testing and Linting

Before opening a pull request, run the local quality checks:

1. Install tooling:

```bash
luarocks install busted
luarocks install luacheck
```

2. Run unit tests:

```bash
REPO_ROOT="$(pwd)" busted --helper spec/spec_helper.lua spec
```

3. Run lint:

```bash
luacheck client/signals.lua client/utils.lua spec
```

> Note: Full resource linting is limited because many files use RedM-specific syntax and runtime natives that standard Lua linters cannot parse or execute directly.

## Reporting Bugs or Requesting Features
If you encounter a bug or have a feature request, please [open an issue](https://github.com/Senexis/RedM-Native-Character-Creator/issues/new/choose) on the GitHub repository page. When opening an issue, please provide as much detail as possible, including the steps to reproduce the bug or a detailed description of the feature request.

## Code of Conduct
This project has a [Code of Conduct](https://github.com/Senexis/RedM-Native-Character-Creator/blob/main/CODE_OF_CONDUCT.md) that outlines how we expect contributors to behave. Please review it before making any contributions.

## License
By contributing to Native Character Creator, you agree that your contributions will be licensed under the [GNU GPL v3 License](https://github.com/Senexis/RedM-Native-Character-Creator/blob/main/LICENSE.md).
