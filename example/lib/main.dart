import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

enum ViewStatus { initial, loading, loaded }

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ViewStatus status = ViewStatus.loading;

  bool get isLoading =>
      status == ViewStatus.loading || status == ViewStatus.initial;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Shimmer Animate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Auto Shimmer Animate'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [
                    const Text('Loading'),
                    Switch(
                      value: isLoading,
                      onChanged: (value) {
                        setState(() {
                          status =
                              value ? ViewStatus.loading : ViewStatus.loaded;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Default'),
                Tab(text: 'Colors'),
                Tab(text: 'Effects'),
                Tab(text: 'Modes'),
                Tab(text: 'Builders'),
                Tab(text: 'State Theme'),
                Tab(text: 'Ignore'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _DefaultTab(isLoading: isLoading),
              _ColorsTab(isLoading: isLoading),
              _EffectsTab(isLoading: isLoading),
              _ModesTab(isLoading: isLoading),
              _BuildersTab(isLoading: isLoading),
              _StateThemeTab(status: status),
              _IgnoreTab(isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultTab extends StatelessWidget {
  const _DefaultTab({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'With child layout',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Without child layout',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            child: const ProductSurfaceBlock(),
          ),
        ),
        _DemoSection(
          title: 'List tiles',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Animation disabled',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            enabled: false,
            child: const ProductListTile(),
          ),
        ),
      ],
    );
  }
}

class _ColorsTab extends StatelessWidget {
  const _ColorsTab({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'Custom colors with child',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            baseColor: Colors.indigo.shade100,
            childBaseColor: Colors.indigo.shade200,
            highlightColor: Colors.white,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Custom colors without child',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            baseColor: Colors.indigo.shade100,
            childBaseColor: Colors.indigo.shade200,
            highlightColor: Colors.white,
            child: const ProductSurfaceBlock(),
          ),
        ),
        _DemoSection(
          title: 'Flat color style',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            baseColor: Colors.teal.shade100,
            childBaseColor: Colors.teal.shade300,
            highlightColor: Colors.white,
            layeredSkeleton: false,
            child: const ProductList(),
          ),
        ),
      ],
    );
  }
}

class _EffectsTab extends StatelessWidget {
  const _EffectsTab({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'Sweep effect',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            effect: const AutoShimmerSweepEffect(
              highlightOpacity: 0.6,
              duration: Duration(milliseconds: 1600),
            ),
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Aurora effect',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            effect: const AutoShimmerAuroraEffect(),
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Pulse effect',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            effect: const AutoShimmerPulseEffect(),
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Raw effect',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            effect: const AutoShimmerRawEffect(
              colors: [
                Colors.transparent,
                Color(0x33FFFFFF),
                Color(0xAAFFFFFF),
                Color(0x33FFFFFF),
                Colors.transparent,
              ],
              stops: [0, 0.25, 0.45, 0.65, 1],
              duration: Duration(milliseconds: 1800),
            ),
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Direction and repeat delay',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            direction: AutoShimmerDirection.leftToRight,
            duration: const Duration(milliseconds: 1200),
            repeatDelay: const Duration(milliseconds: 450),
            child: const ProductList(),
          ),
        ),
      ],
    );
  }
}

class _ModesTab extends StatelessWidget {
  const _ModesTab({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'Child details only',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            onlyChildShimmer: true,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Block and child shimmer',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            blockChildShimmer: true,
            baseColor: Colors.blueGrey.shade100,
            childBaseColor: Colors.blueGrey.shade200,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Block surface only',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            ignoreTexts: true,
            ignoreImages: true,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Switch list tile',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            child: const SettingsTile(),
          ),
        ),
      ],
    );
  }
}

class _BuildersTab extends StatelessWidget {
  const _BuildersTab({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'Custom shimmer builder',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            shimmerBuilder: _softShimmerBuilder,
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Custom loading builder',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            loadingBuilder: _loadingBuilder,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Custom loading builder with disabled animation',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            enabled: false,
            loadingBuilder: _loadingBuilder,
            child: const ProductListTile(),
          ),
        ),
      ],
    );
  }
}

class _StateThemeTab extends StatelessWidget {
  const _StateThemeTab({required this.status});

  final ViewStatus status;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'State based wrapper',
          child: AutoShimmerStateAnimate<ViewStatus>(
            state: status,
            loadingStates: const [
              ViewStatus.initial,
              ViewStatus.loading,
            ],
            child: const ProductList(),
          ),
        ),
        _DemoSection(
          title: 'Theme defaults',
          child: AutoShimmerTheme(
            data: AutoShimmerConfig(
              baseColor: Colors.orange.shade100,
              childBaseColor: Colors.orange.shade200,
              highlightColor: Colors.white,
              duration: const Duration(milliseconds: 1300),
            ),
            child: AutoShimmerAnimate(
              isLoading:
                  status == ViewStatus.initial || status == ViewStatus.loading,
              child: const FeaturedProductCard(),
            ),
          ),
        ),
        _DemoSection(
          title: 'Local override above theme',
          child: AutoShimmerTheme(
            data: AutoShimmerConfig(
              baseColor: Colors.orange.shade100,
              childBaseColor: Colors.orange.shade200,
            ),
            child: AutoShimmerAnimate(
              isLoading:
                  status == ViewStatus.initial || status == ViewStatus.loading,
              baseColor: Colors.purple.shade100,
              childBaseColor: Colors.purple.shade200,
              child: const ProductListTile(),
            ),
          ),
        ),
      ],
    );
  }
}

class _IgnoreTab extends StatelessWidget {
  const _IgnoreTab({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _DemoList(
      sections: [
        _DemoSection(
          title: 'Ignore containers',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            ignoreContainers: true,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Ignore images',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            ignoreImages: true,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Ignore texts',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            ignoreTexts: true,
            child: const FeaturedProductCard(),
          ),
        ),
        _DemoSection(
          title: 'Ignore everything except layout',
          child: AutoShimmerAnimate(
            isLoading: isLoading,
            ignoreContainers: true,
            ignoreImages: true,
            ignoreTexts: true,
            child: const FeaturedProductCard(),
          ),
        ),
      ],
    );
  }
}

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
}

Widget _loadingBuilder(
  BuildContext context,
  Widget child,
  AutoShimmerConfig config,
) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
            color: config.baseColor,
            borderRadius: config.borderRadius,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 210,
          height: 18,
          decoration: BoxDecoration(
            color: config.childBaseColor,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 140,
          height: 14,
          decoration: BoxDecoration(
            color: config.childBaseColor,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    ),
  );
}

class _DemoList extends StatelessWidget {
  const _DemoList({required this.sections});

  final List<_DemoSection> sections;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: sections.length,
      separatorBuilder: (context, index) => const SizedBox(height: 18),
      itemBuilder: (context, index) {
        final section = sections[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(section.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            section.child,
          ],
        );
      },
    );
  }
}

class _DemoSection {
  const _DemoSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
}

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://picsum.photos/seed/auto-shimmer/900/420',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Everyday Travel Pack',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Text(
                  'A compact weather-resistant backpack with smart storage.',
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.star, size: 18),
                    SizedBox(width: 6),
                    Text('4.8 rating'),
                    Spacer(),
                    Text(
                      '\$84.00',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductSurfaceBlock extends StatelessWidget {
  const ProductSurfaceBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (index) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: ProductListTile(),
        ),
      ),
    );
  }
}

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

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SwitchListTile(
      value: true,
      onChanged: null,
      title: Text('Weekly recommendations'),
      subtitle: Text('Notify me when new products are available.'),
      secondary: Icon(Icons.notifications_outlined),
    );
  }
}
