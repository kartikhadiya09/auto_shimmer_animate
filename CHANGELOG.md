# Changelog

## 0.2.1

- Improved default shimmer visibility with softer base colors, a white moving highlight, and tuned sweep timing.
- Added selective child painting controls with `onlyChildShimmer` and `blockChildShimmer`.
- Improved shimmer rendering so parent surfaces and child skeleton details stay visible together.
- Improved card/container skeleton handling for nested child layouts.
- Expanded tests for default shimmer values, nested container rendering, child skeleton modes, aurora configuration, and switch list tiles.
- Reworked the example app around one shared product item with tabs for all package features.
- Replaced the old README/pub.dev GIF set with the new tab-based example GIFs.
- Updated the README use cases with side-by-side previews and compact code-only examples.

## 0.2.0

- Added the built-in `AutoShimmerLayer` animation renderer.
- Added `AutoShimmerEffect` with sweep, raw gradient, pulse, and aurora effects.
- Added `effect` support to `AutoShimmerAnimate`, `AutoShimmerStateAnimate`, and `AutoShimmerConfig`.
- Aligned default shimmer colors, gradient stops, bounds, and duration with the intended package style.
- Removed the `shimmer_animation` dependency from `pubspec.yaml`.
- Removed `Shimmer` and `ShimmerDirection` re-exports from the public API.
- Removed unnecessary `uses-material-design` from `pubspec.yaml`.
- Added `SwitchListTile` skeleton transformation support.
- Improved card surface painting for custom `ShapeBorder` values.
- Added a regression test for skeletonizing a `Container` inside `Expanded`.
- Updated the example with an aurora tab ready for screen recording.
- Replaced the old demo screenshot with separate default, custom color, state, custom builder, and aurora GIFs.
- Reworked the README with side-by-side use cases, effect, theme, state, builder, and example guidance.

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
