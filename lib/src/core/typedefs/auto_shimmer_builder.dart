import 'package:flutter/widgets.dart';

import '../../config/auto_shimmer_config.dart';

/// Builds the final shimmer widget around the generated skeleton child.
typedef AutoShimmerBuilder = Widget Function(
  BuildContext context,
  Widget child,
  AutoShimmerConfig config,
);
