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
    return AutoShimmerTheme(
      data: const AutoShimmerConfig(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auto Shimmer Animate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: Scaffold(
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
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AutoShimmerAnimate(
                isLoading: isLoading,
                child: Card(
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
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Recommended',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              AutoShimmerStateAnimate<ViewStatus>(
                state: status,
                loadingStates: const [ViewStatus.initial, ViewStatus.loading],
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
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
                          subtitle: const Text(
                            'Dimmable warm light with a steel base.',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
