# Auto Shimmer Animate

`auto_shimmer_animate` automatically converts your existing Flutter widgets
into animated shimmer skeleton loaders without creating separate placeholder UI.

[![pub package](https://img.shields.io/pub/v/auto_shimmer_animate.svg)](https://pub.dev/packages/auto_shimmer_animate)
[![likes](https://img.shields.io/pub/likes/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![popularity](https://img.shields.io/pub/popularity/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![license](https://img.shields.io/github/license/kartikhadiya09/auto_shimmer_animate)](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)

Supports Null Safety

Wrap your real UI once and let the package render a shimmer skeleton while data
is loading. Common Flutter widgets are transformed automatically, and custom
widgets fall back gracefully.

## Features

- Automatic shimmer skeleton generation
- No duplicate loading UI
- State-based shimmer support
- Custom shimmer builder
- Global shimmer theme
- Built-in shimmer engine with no third-party shimmer dependency
- Android, iOS, Web, Windows, macOS, Linux

## Preview

<img src="https://raw.githubusercontent.com/kartikhadiya09/auto_shimmer_animate/refs/heads/main/screenshots/auto-shimmer-demo.gif" alt="Auto Shimmer Animate demo" width="320" />

## Installation

```yaml
dependencies:
  auto_shimmer_animate: ^0.0.2
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

### Custom Colors

```dart
AutoShimmerAnimate(
  isLoading: true,
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
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
  data: AutoShimmerConfig(),
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
| `AutoShimmerDirection` | Controls the built-in shimmer sweep direction |

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

MIT License
