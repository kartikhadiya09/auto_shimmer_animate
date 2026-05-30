# Auto Shimmer Animate

`auto_shimmer_animate` automatically converts your existing Flutter widgets
into animated shimmer skeleton loaders without creating separate placeholder UI.

[![pub package](https://img.shields.io/pub/v/auto_shimmer_animate.svg)](https://pub.dev/packages/auto_shimmer_animate)
[![likes](https://img.shields.io/pub/likes/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![popularity](https://img.shields.io/pub/popularity/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![license](https://img.shields.io/github/license/kartikhadiya09/auto_shimmer_animate)](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)

Supports Null Safety

Wrap your real UI once and let the package render a shimmer skeleton while data
is loading. The default colors, timing, layered skeleton rendering, and shimmer
animation are built in, so most screens do not need any custom configuration.

## Features

- Automatic shimmer skeleton generation
- Layered parent and child skeleton colors
- Production-friendly default colors
- Synchronized per-element shimmer animation
- No duplicate loading UI
- State-based shimmer support
- Custom shimmer builder
- Global shimmer theme
- Built-in shimmer engine
- No third-party shimmer dependency
- Android, iOS, Web, Windows, macOS, Linux

## Preview

<img src="https://raw.githubusercontent.com/kartikhadiya09/auto_shimmer_animate/refs/heads/main/screenshots/auto-shimmer-demo.gif" alt="Auto Shimmer Animate demo" width="320" />

## Installation

```yaml
dependencies:
  auto_shimmer_animate: ^0.1.0
```

```sh
flutter pub get
```

## Import

```dart
import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
```

## Usage

### Basic Usage

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  child: ProductCard(),
)
```

No color is required by default. Color and animation parameters are optional;
when you do not pass them, the package uses its internal defaults or the nearest
`AutoShimmerTheme`.

### Default Visuals

| Setting | Default |
|---------|---------|
| `baseColor` | `Color(0xFFE5E7EB)` |
| `childBaseColor` | `Color(0xFFDADDE3)` |
| `highlightColor` | `Color(0xFFF2F4F7)` |
| `highlightOpacity` | `0.35` |
| `highlightWidth` | `0.12` |
| `duration` | `Duration(milliseconds: 1600)` |
| `repeatDelay` | `Duration.zero` |

### Optional Colors

```dart
AutoShimmerAnimate(
  isLoading: true,
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: ProductCard(),
)
```

### Layered Skeleton Colors

```dart
AutoShimmerAnimate(
  isLoading: true,
  baseColor: Colors.grey.shade200,
  childBaseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: ProductCard(),
)
```

Layered rendering is enabled by default. Parent surfaces such as `Card` and
`Container` use `baseColor`; child content such as `Text`, `Image`, and `Icon`
uses `childBaseColor`.

### Flat Skeleton Style

```dart
AutoShimmerAnimate(
  isLoading: true,
  layeredSkeleton: false,
  child: ProductCard(),
)
```

### Custom Timing

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  duration: const Duration(milliseconds: 1200),
  repeatDelay: const Duration(milliseconds: 100),
  child: ProductCard(),
)
```

### Shimmer Tuning

```dart
AutoShimmerAnimate(
  isLoading: true,
  highlightOpacity: 0.35,
  highlightWidth: 0.12,
  child: ProductCard(),
)
```

The built-in shimmer engine uses per-element clipping with a shared animation
scope. That keeps rounded skeleton shapes clean while the shimmer movement stays
aligned across the loading layout.

### Custom Direction

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  direction: AutoShimmerDirection.rightToLeft,
  child: ProductCard(),
)
```

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
  data: const AutoShimmerConfig(),
  child: MyApp(),
)
```

## API Overview

| API | Description |
|------|-------------|
| `AutoShimmerAnimate` | Automatically transforms widgets into shimmer skeletons |
| `AutoShimmerStateAnimate<T>` | State driven shimmer wrapper |
| `AutoShimmerTheme` | Provides global shimmer configuration |
| `AutoShimmerConfig` | Controls optional colors, animation and layered rendering |
| `AutoShimmerDirection` | Controls shimmer sweep direction |

## Example

```sh
cd example
flutter pub get
flutter run
```

See the `example/` directory for a complete runnable Flutter app.

## Additional Information

No third-party shimmer dependency is required. The package includes its own
lightweight shimmer animation engine built with Flutter animation primitives.

The package automatically transforms common Flutter widgets and gracefully
falls back for unsupported custom widgets. For the best layered skeleton output,
build loading layouts from normal Flutter widgets such as `Card`, `Container`,
`Row`, `Column`, `Text`, `Image`, `Icon`, and `ListTile`.

## License

[MIT License](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)
