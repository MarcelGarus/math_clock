import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'math_node_widget.dart';
import 'theme.dart';

class RootWidget extends MathNodeWidget {
  const RootWidget(Root node) : super(node);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RootPainter(color: EquationTheme.of(context).color),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(38, 14, 12, 0),
        child: MathNodeWidget(first),
      ),
    );
  }
}

class _RootPainter extends CustomPainter {
  _RootPainter({@required this.color}) : assert(color != null);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height / 2)
        ..lineTo(10, size.height / 2)
        ..lineTo(20, size.height - 8)
        ..lineTo(30, 4)
        ..lineTo(size.width - 4, 4)
        ..lineTo(size.width - 4, 15),
      Paint()
        ..color = color
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_RootPainter oldDelegate) => oldDelegate.color != color;
}
