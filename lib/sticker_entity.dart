class StickerEntity {
  final String assetsUrl;
  final double width;
  final double height;
  final double top;
  final double left;
  final double scale;

  StickerEntity({
    required this.assetsUrl,
    required this.width,
    required this.height,
    required this.top,
    required this.left,
    this.scale = 1.0,
  });

  StickerEntity copyWith({
    String? assetsUrl,
    double? width,
    double? height,
    double? top,
    double? left,
    double? scale,
  }) {
    return StickerEntity(
      assetsUrl: assetsUrl ?? this.assetsUrl,
      width: width ?? this.width,
      height: height ?? this.height,
      top: top ?? this.top,
      left: left ?? this.left,
      scale: scale ?? this.scale,
    );
  }
}
