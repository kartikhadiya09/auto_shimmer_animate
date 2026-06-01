# Changelog

## 0.1.1

- Restored `shimmer_animation` as the internal shimmer animation engine.
- Added theme-aware default shimmer colors for light and dark mode.
- Aligned default shimmer color, opacity, speed and angle with `shimmer_animation`.
- Updated README examples and package documentation for the new defaults.


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
- Custom shimmer builder support using `shimmer_animation`.
- Runnable example application and pub.dev demo GIF.
