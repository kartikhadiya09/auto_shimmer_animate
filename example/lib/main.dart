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
        length: 21,
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
                Tab(text: 'Flat'),
                Tab(text: 'Sweep'),
                Tab(text: 'Aurora'),
                Tab(text: 'Pulse'),
                Tab(text: 'Raw'),
                Tab(text: 'Direction'),
                Tab(text: 'Delay'),
                Tab(text: 'Highlight'),
                Tab(text: 'Child'),
                Tab(text: 'Block'),
                Tab(text: 'Disabled'),
                Tab(text: 'Builder'),
                Tab(text: 'Loading UI'),
                Tab(text: 'State'),
                Tab(text: 'Theme'),
                Tab(text: 'Ignore Box'),
                Tab(text: 'Ignore Image'),
                Tab(text: 'Ignore Text'),
                Tab(text: 'Radius'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _FeatureDemo(
                title: 'Default shimmer',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Custom colors',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  baseColor: Colors.indigo.shade100,
                  childBaseColor: Colors.indigo.shade200,
                  highlightColor: Colors.white,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Flat skeleton color',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  layeredSkeleton: false,
                  baseColor: Colors.teal.shade100,
                  highlightColor: Colors.white,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Sweep effect',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  effect: const AutoShimmerSweepEffect(
                    highlightOpacity: 0.62,
                    duration: Duration(milliseconds: 1600),
                  ),
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Aurora effect',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  effect: const AutoShimmerAuroraEffect(),
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Pulse effect',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  effect: const AutoShimmerPulseEffect(),
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Raw effect',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  effect: const AutoShimmerRawEffect(
                    colors: [
                      Colors.transparent,
                      Color(0x26FFFFFF),
                      Color(0xCCFFFFFF),
                      Color(0x26FFFFFF),
                      Colors.transparent,
                    ],
                    stops: [0, 0.25, 0.48, 0.72, 1],
                    duration: Duration(milliseconds: 1700),
                  ),
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Custom direction',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  direction: AutoShimmerDirection.leftToRight,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Repeat delay',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  duration: const Duration(milliseconds: 1200),
                  repeatDelay: const Duration(milliseconds: 500),
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Highlight intensity',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  highlightOpacity: 0.78,
                  highlightWidth: 0.32,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Only child shimmer',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  onlyChildShimmer: true,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Block with child shimmer',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  blockChildShimmer: true,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Animation disabled',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  enabled: false,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Custom shimmer builder',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  shimmerBuilder: _softShimmerBuilder,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Custom loading builder',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  loadingBuilder: _loadingBuilder,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'State based loading',
                child: AutoShimmerStateAnimate<ViewStatus>(
                  state: status,
                  loadingStates: const [
                    ViewStatus.initial,
                    ViewStatus.loading,
                  ],
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Theme defaults',
                child: AutoShimmerTheme(
                  data: AutoShimmerConfig(
                    baseColor: Colors.orange.shade100,
                    childBaseColor: Colors.orange.shade200,
                    highlightColor: Colors.white,
                    duration: const Duration(milliseconds: 1300),
                  ),
                  child: AutoShimmerAnimate(
                    isLoading: isLoading,
                    child: const ProductDemoItem(),
                  ),
                ),
              ),
              _FeatureDemo(
                title: 'Ignore containers',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  ignoreContainers: true,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Ignore images',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  ignoreImages: true,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Ignore texts',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  ignoreTexts: true,
                  child: const ProductDemoItem(),
                ),
              ),
              _FeatureDemo(
                title: 'Custom border radius',
                child: AutoShimmerAnimate(
                  isLoading: isLoading,
                  borderRadius: BorderRadius.circular(18),
                  child: const ProductDemoItem(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureDemo extends StatelessWidget {
  const _FeatureDemo({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        ),
      ),
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
        highlightOpacity: 0.82,
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
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(color: config.baseColor),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 240,
                height: 22,
                decoration: BoxDecoration(
                  color: config.childBaseColor,
                  borderRadius: config.borderRadius,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 14,
                decoration: BoxDecoration(
                  color: config.childBaseColor,
                  borderRadius: config.borderRadius,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 180,
                height: 14,
                decoration: BoxDecoration(
                  color: config.childBaseColor,
                  borderRadius: config.borderRadius,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 96,
                    height: 18,
                    decoration: BoxDecoration(
                      color: config.childBaseColor,
                      borderRadius: config.borderRadius,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 72,
                    height: 24,
                    decoration: BoxDecoration(
                      color: config.childBaseColor,
                      borderRadius: config.borderRadius,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: config.childBaseColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: config.childBaseColor,
                    borderRadius: config.borderRadius,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 50,
                height: 28,
                decoration: BoxDecoration(
                  color: config.childBaseColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ProductDemoItem extends StatelessWidget {
  const ProductDemoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://picsum.photos/seed/auto-shimmer-item/900/420',
            height: 150,
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
                SizedBox(height: 14),
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
          const Divider(height: 1),
          const SwitchListTile(
            value: true,
            onChanged: null,
            title: Text('Weekly recommendations'),
            subtitle: Text('New arrivals and price drops'),
            secondary: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }
}
