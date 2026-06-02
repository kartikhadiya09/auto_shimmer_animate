# Auto Shimmer Animate

`auto_shimmer_animate` turns your existing Flutter UI into animated skeleton
loading placeholders. Wrap the real layout once, pass a loading flag, and the
package builds the placeholder tree for you.

[![pub package](https://img.shields.io/pub/v/auto_shimmer_animate.svg)](https://pub.dev/packages/auto_shimmer_animate)
[![likes](https://img.shields.io/pub/likes/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![popularity](https://img.shields.io/pub/popularity/auto_shimmer_animate)](https://pub.dev/packages/auto_shimmer_animate/score)
[![license](https://img.shields.io/github/license/kartikhadiya09/auto_shimmer_animate)](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)

## Introduction

Skeleton loading keeps a screen shaped like the final content while data is
being fetched. This package reduces common Flutter widgets into skeleton boxes,
text bars, image blocks, icon circles, cards, list tiles, and switch list tiles,
then paints an internal shimmer effect over the generated layout.

The goal is to avoid maintaining duplicate loading screens. Your normal UI
stays the source of truth, and the loading state follows the same spacing,
constraints, and hierarchy.

## Installation

```yaml
dependencies:
  auto_shimmer_animate: ^0.2.0
```

```sh
flutter pub get
```

## Import

```dart
import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
```

## Features

- Automatic skeleton generation from existing widget trees
- Built-in shimmer engine with no third-party shimmer dependency
- Directional sweep, raw gradient, pulse, and aurora effects
- Light and dark adaptive defaults
- Layered parent/content skeleton colors
- Boolean and state-based loading APIs
- Custom loading builders and shimmer wrappers
- Theme-level configuration with local overrides
- Support for common layout, text, image, icon, card, list tile, and switch tile widgets

When `isLoading` is `false`, the original child is returned untouched. When it
is `true`, the package builds a skeleton version and disables pointer events
and semantics for the loading placeholder.

## Use Cases

All previews use the same demo layout: a featured product card followed by a
recommended product tile list.

```dart
class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://picsum.photos/seed/product-list/96',
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: const Text('Minimal Desk Lamp'),
        subtitle: const Text('Dimmable warm light with a steel base.'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
```

### Default shimmer

<table>
<tr>
<td width="52%">

<pre><code class="language-dart">AutoShimmerAnimate(
  isLoading: isLoading,
  child: const ProductList(),
)</code></pre>

</td>
<td width="48%">

<img src="https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/screenshots/default-example.gif?raw=true" alt="Default shimmer demo" width="320" />

</td>
</tr>
</table>

### Custom colors

<table>
<tr>
<td width="52%">

<pre><code class="language-dart">AutoShimmerAnimate(
  isLoading: isLoading,
  baseColor: Colors.indigo.shade100,
  childBaseColor: Colors.indigo.shade200,
  highlightColor: Colors.white,
  child: const ProductList(),
)</code></pre>

</td>
<td width="48%">

<img src="https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/screenshots/custom-color-example.gif?raw=true" alt="Custom colors demo" width="320" />

</td>
</tr>
</table>

### State based loading

<table>
<tr>
<td width="52%">

<pre><code class="language-dart">AutoShimmerStateAnimate&lt;ViewStatus&gt;(
  state: status,
  loadingStates: const [
    ViewStatus.initial,
    ViewStatus.loading,
  ],
  child: const ProductList(),
)</code></pre>

</td>
<td width="48%">

<img src="https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/screenshots/state-based-example.gif?raw=true" alt="State based loading demo" width="320" />

</td>
</tr>
</table>

### Custom builder

<table>
<tr>
<td width="52%">

<pre><code class="language-dart">AutoShimmerAnimate(
  isLoading: isLoading,
  shimmerBuilder: _softShimmerBuilder,
  child: const ProductList(),
)

Widget _softShimmerBuilder(
  BuildContext context,
  Widget child,
  AutoShimmerConfig config,
) {
  return AutoShimmerLayer(
    config: config.copyWith(
      effect: AutoShimmerSweepEffect(
        highlightColor: Colors.teal.shade50,
        highlightOpacity: 0.8,
        duration: const Duration(milliseconds: 1400),
      ),
    ),
    child: child,
  );
}</code></pre>

</td>
<td width="48%">

<img src="https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/screenshots/custom-builder-example.gif?raw=true" alt="Custom builder demo" width="320" />

</td>
</tr>
</table>

### Aurora effect

<table>
<tr>
<td width="52%">

<pre><code class="language-dart">AutoShimmerAnimate(
  isLoading: isLoading,
  effect: const AutoShimmerAuroraEffect(),
  child: const ProductList(),
)</code></pre>

</td>
<td width="48%">

<img src="https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/screenshots/aurora-example.gif?raw=true" alt="Aurora effect demo" width="320" />

</td>
</tr>
</table>

## Provide Layout Data

The package needs a widget tree to skeletonize. If your list is empty while
loading, provide temporary placeholder items so the layout has a shape.

```dart
final visibleProducts = isLoading
    ? List.filled(6, Product.placeholder())
    : products;

AutoShimmerAnimate(
  isLoading: isLoading,
  child: ProductList(products: visibleProducts),
)
```

For network images, avoid invalid URLs during loading by passing an empty image
widget, a local placeholder, or `ignoreImages: true`.

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  ignoreImages: true,
  child: ProductCard(product: product),
)
```

## Colors

`baseColor` paints parent surfaces such as cards and containers.
`childBaseColor` paints content such as text, images, and icons when
`layeredSkeleton` is enabled. `highlightColor` controls the moving shimmer
overlay. A short custom-color example is shown in the Use Cases section.

## Effects

### Sweep

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  effect: const AutoShimmerSweepEffect(
    highlightColor: Colors.white,
    highlightOpacity: 1.0,
    highlightWidth: 0.1,
    duration: Duration(milliseconds: 2000),
  ),
  child: ProductCard(product: product),
)
```

### Pulse

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  effect: const AutoShimmerPulseEffect(),
  child: ProductCard(product: product),
)
```

Use `AutoShimmerRawEffect` when you want full control over gradient colors,
stops, alignments, bounds, and duration.

## Direction And Timing

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  direction: AutoShimmerDirection.leftToRight,
  duration: const Duration(milliseconds: 1400),
  repeatDelay: const Duration(milliseconds: 120),
  child: ProductCard(product: product),
)
```

`enabled: false` keeps the generated skeleton visible without running the
animation.

## Global Theme

```dart
AutoShimmerTheme(
  data: const AutoShimmerConfig(
    baseColor: Color(0xFFE6E8EF),
    childBaseColor: Color(0xFFD6DAE2),
    effect: AutoShimmerAuroraEffect(),
  ),
  child: MyApp(),
)
```

Values passed directly to `AutoShimmerAnimate` override the nearest
`AutoShimmerTheme`.

## State-Based Usage

Use `AutoShimmerStateAnimate<T>` when your screen is driven by enum, string, or
object states instead of a boolean loading flag. A short state-based example is
shown in the Use Cases section.

## Custom Builders

Use `loadingBuilder` to skip automatic skeleton generation and provide your own
loading UI. The returned widget still receives the default shimmer layer.

```dart
AutoShimmerAnimate(
  isLoading: isLoading,
  loadingBuilder: (context, _, config) {
    return SizedBox(
      height: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: config.baseColor,
          borderRadius: config.borderRadius,
        ),
      ),
    );
  },
  child: ProductCard(product: product),
)
```

Use `shimmerBuilder` to replace how the generated skeleton is animated. A short
`shimmerBuilder` example is shown in the Use Cases section.

## Example App

```sh
cd example
flutter pub get
flutter run
```

The example includes default shimmer, custom colors, state-based loading,
custom builder usage, and an aurora tab that is ready for GIF or screen
recording capture.

## API Overview

| API | Description |
| --- | --- |
| `AutoShimmerAnimate` | Boolean loading wrapper that skeletonizes a child |
| `AutoShimmerStateAnimate<T>` | State-driven loading wrapper |
| `AutoShimmerTheme` | Provides global defaults to a subtree |
| `AutoShimmerConfig` | Holds colors, timing, effect, and skeleton settings |
| `AutoShimmerLayer` | Built-in shimmer renderer used by default |
| `AutoShimmerSweepEffect` | Default directional shimmer effect |
| `AutoShimmerAuroraEffect` | Multi-color aurora shimmer effect |
| `AutoShimmerPulseEffect` | Low-motion pulse effect |
| `AutoShimmerRawEffect` | Fully custom gradient shimmer effect |

## Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `isLoading` | `bool` | required | Shows skeleton when true |
| `child` | `Widget` | required | Widget tree to skeletonize |
| `baseColor` | `Color?` | adaptive | Parent surface skeleton color |
| `childBaseColor` | `Color?` | adaptive | Content skeleton color |
| `highlightColor` | `Color?` | `0xFFF4F4F4` | Sweep highlight color |
| `effect` | `AutoShimmerEffect?` | sweep | Custom shimmer effect |
| `duration` | `Duration?` | `2000ms` | Sweep duration |
| `repeatDelay` | `Duration?` | `0ms` | Delay between sweep repeats |
| `direction` | `AutoShimmerDirection?` | diagonal | Sweep direction |
| `borderRadius` | `BorderRadius?` | `8px` | Default skeleton radius |
| `enabled` | `bool?` | `true` | Enables or disables animation |
| `layeredSkeleton` | `bool?` | `true` | Uses separate parent/content colors |
| `highlightOpacity` | `double?` | `1.0` | Sweep highlight opacity |
| `highlightWidth` | `double?` | `0.1` | Sweep highlight band width |
| `ignoreContainers` | `bool` | `false` | Keeps container visuals unchanged |
| `ignoreImages` | `bool` | `false` | Keeps image widgets visible |
| `ignoreTexts` | `bool` | `false` | Keeps text widgets visible |
| `loadingBuilder` | `AutoShimmerBuilder?` | null | Custom loading UI |
| `shimmerBuilder` | `AutoShimmerBuilder?` | null | Custom shimmer wrapper |

## License

[MIT License](https://github.com/kartikhadiya09/auto_shimmer_animate/blob/main/LICENSE)
