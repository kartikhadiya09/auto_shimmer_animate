import 'package:flutter/widgets.dart';

import '../core/enums/shimmer_node_kind.dart';
import '../models/shimmer_node.dart';

/// Contract implemented by every widget-to-skeleton transformer.
abstract interface class WidgetTransformer {
  /// Category produced by this transformer.
  ShimmerNodeKind get nodeKind;

  /// Whether this transformer can handle [widget].
  bool canTransform(Widget widget);

  /// Converts [node] into a skeleton widget.
  Widget transform(BuildContext context, ShimmerNode node);
}
