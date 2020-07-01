import 'package:flutter/material.dart';

class RoundedTabIndicator extends Decoration {
  const RoundedTabIndicator({@required this.height, @required this.color});

  final double height;
  final Color color;

  @override
  _RoundedPainter createBoxPainter([VoidCallback onChanged]) {
    return _RoundedPainter(this, height, color, onChanged);
  }
}

class _RoundedPainter extends BoxPainter {
  _RoundedPainter(
      this.decoration, this.height, this.color, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final RoundedTabIndicator decoration;
  final double height;
  final Color color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect =
        Offset(offset.dx, (configuration.size.height / 2) - height / 2) &
            Size(configuration.size.width, height);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(height / 2)), paint);
  }
}
