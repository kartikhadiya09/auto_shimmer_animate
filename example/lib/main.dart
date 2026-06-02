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
        length: 5,
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
                Tab(text: 'Custom Colors'),
                Tab(text: 'State Based'),
                Tab(text: 'Custom Builder'),
                Tab(text: 'Aurora'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _ExampleList(
                header: AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: const FeaturedProductCard(),
                ),
                list: AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: const ProductList(),
                ),
              ),
              _ExampleList(
                header: AutoShimmerAnimate(
                  isLoading: isLoading,
                  baseColor: Colors.indigo.shade100,
                  childBaseColor: Colors.indigo.shade200,
                  highlightColor: Colors.white,
                  child: const FeaturedProductCard(),
                ),
                list: AutoShimmerAnimate(
                  isLoading: isLoading,
                  baseColor: Colors.indigo.shade100,
                  childBaseColor: Colors.indigo.shade200,
                  highlightColor: Colors.white,
                  child: const ProductList(),
                ),
              ),
              _ExampleList(
                header: AutoShimmerStateAnimate<ViewStatus>(
                  state: status,
                  loadingStates: const [
                    ViewStatus.initial,
                    ViewStatus.loading,
                  ],
                  child: const FeaturedProductCard(),
                ),
                list: AutoShimmerStateAnimate<ViewStatus>(
                  state: status,
                  loadingStates: const [
                    ViewStatus.initial,
                    ViewStatus.loading,
                  ],
                  child: const ProductList(),
                ),
              ),
              _ExampleList(
                header: AutoShimmerAnimate(
                  isLoading: isLoading,
                  shimmerBuilder: _softShimmerBuilder,
                  child: const FeaturedProductCard(),
                ),
                list: AutoShimmerAnimate(
                  isLoading: isLoading,
                  shimmerBuilder: _softShimmerBuilder,
                  child: const ProductList(),
                ),
              ),
              _ExampleList(
                header: AutoShimmerAnimate(
                  isLoading: isLoading,
                  effect: const AutoShimmerAuroraEffect(),
                  child: const FeaturedProductCard(),
                ),
                list: AutoShimmerAnimate(
                  isLoading: isLoading,
                  effect: const AutoShimmerAuroraEffect(),
                  child: const ProductList(),
                ),
              ),
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
        highlightOpacity: 0.8,
        duration: const Duration(milliseconds: 1400),
      ),
    ),
    child: child,
  );
}

class _ExampleList extends StatelessWidget {
  const _ExampleList({
    required this.header,
    required this.list,
  });

  final Widget header;
  final Widget list;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        header,
        const SizedBox(height: 20),
        Text('Recommended', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        list,
      ],
    );
  }
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
