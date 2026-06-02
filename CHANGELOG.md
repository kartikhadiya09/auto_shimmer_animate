# Changelog

## 0.2.0

- Added the built-in `AutoShimmerLayer` animation renderer.
- Added `AutoShimmerEffect` with sweep, raw gradient, pulse, and aurora effects.
- Added `effect` support to `AutoShimmerAnimate`, `AutoShimmerStateAnimate`, and `AutoShimmerConfig`.
- Aligned default shimmer colors, gradient stops, bounds, and duration with the intended package style.
- Removed the third-party shimmer dependency from the package API and pubspec.
- Removed unnecessary `uses-material-design` from `pubspec.yaml`.
- Added `SwitchListTile` skeleton transformation support.
- Improved card surface painting for custom `ShapeBorder` values.
- Added a regression test for skeletonizing a `Container` inside `Expanded`.
- Updated the example with an aurora tab ready for screen recording.
- Reworked the README with effect, theme, state, builder, and example guidance.

## 0.1.1

- Fixed default shimmer highlight to use soft light grey instead of harsh pure white.
- Reduced default highlight width for more subtle shimmer animation.
- Added `loadingBuilder` parameter for custom loading UI (skips auto-skeleton generation).
- Clarified `shimmerBuilder` usage: wraps generated skeleton with custom animation only.
- Improved color behavior: user-provided colors are always respected exactly.
- Updated README with custom loading UI and shimmer animation builder examples.



## 0.1.0

- Added layered skeleton rendering.
- Added childBaseColor customization.
- Added layeredSkeleton toggle.
- Improved default shimmer appearance.
- Improved container, card, image, icon and text skeleton rendering.
- Improved default shimmer color contrast.
- Added synchronized per-element shimmer animation.
- Added highlightOpacity and highlightWidth tuning.
- Improved shared shimmer gradient alignment.
- Kept optional color overrides default-safe.

## 0.0.2

- Removed third-party shimmer animation dependency.
- Added built-in shimmer animation engine.
- Added `repeatDelay` support.
- Added internal shimmer direction enum.
- Improved package independence and maintainability.

## 0.0.1

### Added

- Initial release of `auto_shimmer_animate`.
- `AutoShimmerAnimate` for boolean loading states.
- `AutoShimmerStateAnimate<T>` for enum, string, object, and custom state values.
- `AutoShimmerTheme` and `AutoShimmerConfig` for subtree defaults.
- Automatic skeleton conversion for common Flutter widgets.
- Custom shimmer builder support.
- Runnable example application and pub.dev demo GIF.
