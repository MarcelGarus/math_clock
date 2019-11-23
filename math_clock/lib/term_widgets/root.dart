import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'theme.dart';

class RootWidget extends TermWidget {
  const RootWidget(Root root) : super(root);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RootPainter(color: TermTheme.of(context).color),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(38, 14, 12, 0),
        child: TermWidget(first),
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
        // The small horizontal bar on the left.
        ..lineTo(10, size.height / 2)
        // Go all the way down.
        ..lineTo(20, size.height - 8)
        // Then, go way up again.
        ..lineTo(30, 4)
        // A long horizontal bar above the child.
        ..lineTo(size.width - 4, 4)
        // Finally, a quick stroke down to indicate the end of the root.
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
