/// Describes the category of widget currently being transformed.
enum ShimmerNodeKind {
  /// A `Text` or `RichText` widget.
  text,

  /// An `Image` widget.
  image,

  /// An `Icon` widget.
  icon,

  /// A visual container widget.
  container,

  /// A layout widget that mainly preserves structure.
  layout,

  /// A Material adapter such as `Card` or `ListTile`.
  adapter,

  /// Any unsupported widget handled by the graceful fallback.
  fallback,
}
