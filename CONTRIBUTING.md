# MarkDartix Contributing Guide

We are really excited that you are interested in contributing to MarkDartix :tada:. Before submitting your contribution, please make sure to take a moment and read through the following guidelines.

- [Code of Conduct](.github/CODE_OF_CONDUCT.md)
- [Philosophy](#philosophy)
- [Issue reporting guidelines](#issue-reporting-guidelines)
- [Pull request guidelines](#pull-request-guidelines)
  - [Where should I start?](#where-should-i-start)
- [Quick start](#quick-start)
  - [Build instructions](#build-instructions)
  - [Style guide](#style-guide)
- [Developer documentation](#developer-documentation)

## Philosophy

🔑 Our philosophy is to keep things clean, simple and minimal. 
MarkDartix is constantly changing and we want these improvements to align with our philosophy. For example, look at the side bar and tabs; these two panels provide awesome functionality *and* aren't distracting to the user. We'll continue adding more features (like plugins) that can be activated via 'settings' to improve MarkDartix. This will allow everyone to customize MarkDartix for their needs and provide a minimal default interface.

## Issue Reporting Guidelines

Please search for similar issues before opening an issue and always follow the [issue template](.github/ISSUE_TEMPLATE/). Please review the following Pull Request guidelines before making your own PR. 

## Pull Request Guidelines

**In *all* Pull Requests:** provide a detailed description of the problem, as well as a demonstration with screen recordings and/or screenshots.

Please make sure the following is done before submitting a PR:

- Submit PRs directly to the `develop` branch.
- Reference the related issue in the PR comment.
- Utilize [DartDoc](https://dart.dev/guides/language/effective-dart/documentation) for better code documentation.
- Ensure all tests pass.
- Please lint (`flutter analyze`) your PR.
- All PRs need to pass the **CI** before merged. If it fails, please try to solve the issue(s) and feel free to ask for any help.

If you add new feature:

- Open a suggestion issue first.
- Provide your reasoning on why you want to add this feature.
- Submit your PR.

If you fix a bug:

- If you are resolving a special issue, please add `Fix #<issue number>: <short message>` in your PR title (e.g.`Fix #3899: Update entities encoding/decoding`).
- Provide a detailed description of the bug in your PR and/or link to the issue. 

### Where should I start?

A good way to start is to find an [issue](https://github.com/calcitem/markdartix/issues) labeled as `bug`, `help wanted` or `feature request`. The `good first issue` issues are good for newcomers. Please discuss the solution for larger issues first and after the final solution is approved by the MarkDartix members, you can submit/work on the PR. For small changes you can directly open a PR.

Other ways to help:

- Documentation
- Translation (currently unavailable)
- Design icons and logos
- Improve the UI
- Write tests for MarkDartix
- Share your thoughts! We want to hear about features you think are missing, any bugs you find, and why you :heart: MarkDartix.

## Quick start

1. Fork the repository.
2. Clone your fork: `git clone git@github.com:<username>/markdartix.git`
3. Create a feature branch: `git checkout -b feature`
4. Make your changes and push your branch.
5. Create a PR against `develop` and describe your changes.

**Rebase your PR:**

If there are conflicts or you want to update your local branch, please do the following:

1. `git fetch upstream`
2. `git rebase upstream/develop`
3. Please [resolve](https://help.github.com/articles/resolving-merge-conflicts-after-a-git-rebase/) all conflicts and force push your feature branch: `git push -f`

### Build Instructions

🔗 [Build Instructions](docs/dev/BUILD.md)

### Style Guide

You can run `flutter analyze` to help you to follow the style guide.

- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- 2 space indent
- Use DartDoc for documentation: [DartDoc](https://dart.dev/guides/language/effective-dart/documentation)

## Developer Documentation

Please [click here](docs/dev/README.md) for more details.
