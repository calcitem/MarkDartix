# Steps to release MarkDartix

- Create a release candidate
  - Create branch `release-v%version%`
  - Set environment variable `MARKDARTIX_IS_STABLE` to `1` (if necessary)
  - Ensure [changelog](https://github.com/calcitem/markdartix/blob/master/.github/CHANGELOG.md) is up-to-date
  - Bump version in `pubspec.yaml` and changelog
  - Update all `README.md` files
  - Create commit `release version %version%`
  - Ensure all tests pass
  - A new draft release should be available or create one
- Publish GitHub release
  - Add git tag `v%version%`
  - Add changelog
  - Add SHA256 checksums
- Update website and documentation
- Publish package to pub.dev
  - Ensure package is up-to-date and follows [Flutter package publishing guidelines](https://dart.dev/tools/pub/publishing)
  - Run `flutter packages pub publish` to publish the package

## Work after releasing

- Ensure all issues in the changelog are closed
- 😌 🎉
