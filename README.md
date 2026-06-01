# Auto Shimmer Animate

`auto_shimmer_animate` automatically converts your existing Flutter widgets
into animated shimmer skeleton loaders without creating separate placeholder UI.

[![pub package](https://img.shields.io/pub/v/auto_shimmer_animate.svg)](https://pub.dev/packages/auto_shimmer_animate)
[![likes](https://img.shields.io/pub/likes/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![popularity](https://img.shields.io/pub/popularity/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![license](https://img.shields.io/github/license/kartikhadiya09/auto_shimmer_animate)](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)

Supports Null Safety

Wrap your real UI once and let the package render a shimmer skeleton while data
is loading. The shimmer animation is powered internally by
[`shimmer_animation`](https://pub.dev/packages/shimmer_animation), and default
colors automatically adapt to light and dark themes.
By default, shimmer color, opacity, speed, and angle follow
`shimmer_animation` defaults.

## Features

- Automatic shimmer skeleton generation
- No duplicate loading UI
- Theme-aware light and dark shimmer colors
- State-based shimmer support
- Custom loading UI builder
- Custom shimmer animation builder
- Global shimmer theme
- Uses `shimmer_animation` internally
- Android, iOS, Web, Windows, macOS, Linux

## Preview

<img src="https://raw.githubusercontent.com/kartikhadiya09/auto_shimmer_animate/refs/heads/main/screenshots/auto-shimmer-demo.gif" alt="Auto Shimmer Animate demo" width="320" />

## Installation

```yaml
dependencies:
  auto_shimmer_animate: ^0.1.1
```

```sh
flutter pub get
```

## Import

```dart
import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
```

## Usage

### Basic Auto Shimmer

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  child: ProductCard(),
)
```

The package automatically generates a skeleton from your widget tree with soft
default colors and a subtle shimmer effect.

### Custom Skeleton Colors

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: ProductCard(),
)
```

- **baseColor**: Skeleton shape color (parent surfaces)
- **highlightColor**: Moving shimmer highlight color
- **childBaseColor**: Skeleton color for child content (when layeredSkeleton is enabled)

### Layered Skeleton

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  baseColor: Colors.grey.shade300,
  childBaseColor: Colors.grey.shade400,
  layeredSkeleton: true,
  child: ProductCard(),
)
```

Separates the skeleton color for container surfaces and content elements for
better visual hierarchy.

### Custom Loading UI

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  loadingBuilder: (context, _, config) {
    return Container(
      height: 100,
      color: config.baseColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  },
  child: ProductCard(),
)
```

When `loadingBuilder` is provided, the package skips automatic skeleton
generation and uses your custom loading UI instead. The shimmer animation is
still applied.

### Custom Shimmer Animation

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  shimmerBuilder: (context, skeleton, config) {
    return Shimmer(
      color: config.highlightColor,
      duration: config.duration,
      interval: config.repeatDelay,
      enabled: config.enabled,
      child: skeleton,
    );
  },
  child: ProductCard(),
)
```

Use `shimmerBuilder` to customize how the shimmer animation wraps the generated
skeleton. Only used when `loadingBuilder` is not provided.

### State-Based Usage

```dart
AutoShimmerStateAnimate<ViewStatus>(
  state: status,
  loadingStates: const [ViewStatus.loading],
  child: ProfileView(),
)
```

### Global Theme

```dart
AutoShimmerTheme(
  data: const AutoShimmerConfig(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
  ),
  child: MyApp(),
)
```

## API Overview

| API | Description |
|------|-------------|
| `AutoShimmerAnimate` | Automatically transforms widgets into shimmer skeletons |
| `AutoShimmerStateAnimate<T>` | State-driven shimmer wrapper |
| `AutoShimmerTheme` | Provides global shimmer configuration |
| `AutoShimmerConfig` | Controls shimmer appearance and behavior |
| `AutoShimmerDirection` | Controls shimmer sweep direction |

## Parameters

| Parameter | Type | Default  | Description |
|-----------|------|----------|-------------|
| isLoading | bool | required | Show skeleton when true |
| child | Widget | required | Widget to skeletonize |
| baseColor | Color? | -        | Skeleton base color |
| childBaseColor | Color? | -        | Child content skeleton color |
| highlightColor | Color? | -        | Shimmer highlight color |
| loadingBuilder | AutoShimmerBuilder? | -        | Custom loading UI (skips auto-skeleton) |
| shimmerBuilder | AutoShimmerBuilder? | -        | Custom shimmer animation wrapper |
| duration | Duration? | 3s       | Shimmer sweep duration |
| repeatDelay | Duration? | 0ms      | Delay between sweeps |
| borderRadius | BorderRadius? | 8px      | Skeleton border radius |
| layeredSkeleton | bool? | true     | Separate colors for parent/child |
| highlightOpacity | double? | 0.8      | Shimmer highlight opacity |
| highlightWidth | double? | 0.12     | Shimmer highlight width |

## Example

```sh
cd example
flutter pub get
flutter run
```

See the `example/` directory for a complete runnable Flutter app.

## Additional Information

The package automatically transforms common Flutter widgets and gracefully
falls back for unsupported custom widgets.

## License

[MIT License](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)
