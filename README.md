# Auto Shimmer Animate

`auto_shimmer_animate` is a Flutter package that automatically converts your
existing widget tree into an animated shimmer skeleton loading state.

Most shimmer packages require a second handcrafted placeholder layout. This
package lets you write your real UI once, then wrap it:

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  child: ProductCard(),
)
```

When loading is enabled, common Flutter widgets are converted into skeleton
shapes and animated with [`shimmer_animation`](https://pub.dev/packages/shimmer_animation).

## Features

- One-widget shimmer skeleton wrapper
- No separate placeholder UI required for common layouts
- Boolean and state-based loading APIs
- Supports enum, string, object, and custom state values
- Converts common widgets such as `Text`, `RichText`, `Image`, `Icon`,
  `Container`, `Card`, `ListTile`, `Row`, `Column`, `Stack`, `Padding`,
  `SizedBox`, and `ClipRRect`
- Custom base color, highlight color, duration, interval, radius, and direction
- App-wide defaults with `AutoShimmerTheme`
- Custom shimmer builder support
- Android, iOS, Web, Windows, macOS, and Linux support
- Null-safe Dart API

## Preview

<img src="https://raw.githubusercontent.com/kartikhadiya09/auto_shimmer_animate/refs/heads/main/screenshots/auto-shimmer-demo.gif" alt="Auto Shimmer Animate demo" width="320" />

## Why This Package Exists

Loading skeletons are useful, but maintaining a duplicate shimmer UI beside the
real UI is repetitive and error-prone. `auto_shimmer_animate` keeps loading
states close to the real layout by transforming common widgets automatically and
falling back gracefully for unsupported custom widgets.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  auto_shimmer_animate: ^0.0.1
```

Then run:

```sh
flutter pub get
```

Import the package:

```dart
import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
```

## Usage

Wrap the widget you already use in your screen. When `isLoading` is false, the
original child is returned directly. When `isLoading` is true, the package
generates and animates a skeleton version of the child.

### Basic Example

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  child: ProductCard(),
)
```

### Custom Colors

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: ProductCard(),
)
```

### Full Customization

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  duration: const Duration(milliseconds: 1200),
  interval: const Duration(milliseconds: 250),
  borderRadius: BorderRadius.circular(12),
  enabled: true,
  child: ProductCard(),
)
```

### State-Based Shimmer

Use `AutoShimmerStateAnimate` when your UI is driven by a view state instead of
a boolean.

```dart
enum ViewStatus { initial, loading, success, failure }

AutoShimmerStateAnimate<ViewStatus>(
  state: status,
  loadingStates: const [ViewStatus.loading, ViewStatus.initial],
  child: ProfileView(),
)
```

The generic type can be an enum, string, object, or any other value with
meaningful equality:

```dart
AutoShimmerStateAnimate<String>(
  state: controller.state,
  loadingStates: const ['loading'],
  child: HomeView(),
)
```

### App-Wide Theme

```dart
AutoShimmerTheme(
  data: AutoShimmerConfig(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    duration: const Duration(milliseconds: 1200),
    borderRadius: BorderRadius.circular(12),
  ),
  child: MyApp(),
)
```

### Custom Shimmer Builder

Provide a custom builder when you want full control over how the generated
skeleton is animated.

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  shimmerBuilder: (context, child, config) {
    return Shimmer(
      color: config.highlightColor,
      duration: config.duration,
      interval: config.interval,
      enabled: config.enabled,
      child: child,
    );
  },
  child: ProductCard(),
)
```

## Complete Example

```dart
import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Auto Shimmer Animate'),
          actions: [
            Switch(
              value: isLoading,
              onChanged: (value) => setState(() => isLoading = value),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return AutoShimmerAnimate(
              isLoading: isLoading,
              child: const ProductCard(),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/96',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wireless Headphones',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text('Noise cancelling audio with long battery life.'),
                  SizedBox(height: 8),
                  Text('\$129.00'),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
```

## API Overview

### `AutoShimmerAnimate`

Wraps any widget and renders its shimmer skeleton when `isLoading` is true.

### `AutoShimmerStateAnimate<T>`

State-based wrapper that shows the skeleton when `state` is included in
`loadingStates`.

### `AutoShimmerTheme`

Provides default shimmer configuration to a whole subtree.

### `AutoShimmerConfig`

Controls base color, highlight color, duration, interval, border radius,
direction, and animation enabled state.

## Example App

Run the example app from the package root:

```sh
cd example
flutter pub get
flutter run
```

The example includes boolean loading, state-based loading, themed shimmer
colors, and common product-card layouts.

## Notes

Flutter does not expose the internals of every custom widget at runtime. This
package transforms common public Flutter widgets automatically and applies a
graceful shimmer fallback for unsupported custom widgets.

## Publishing Checklist

Before publishing:

```sh
flutter pub get
dart format .
flutter analyze
flutter test
dart pub publish --dry-run
```

Publish:

```sh
dart pub publish
```

## License

MIT License. See [LICENSE](LICENSE).
