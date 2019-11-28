import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'theme.dart';

/// Displays parenthesis (that's "(" and ")") around the given [term].
class ParenthesisWidget extends TermWidget {
  const ParenthesisWidget(Term term)
      : assert(
            term is! Number, 'Numbers should never be put into parenthesis.'),
        super(term);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParenthesisPainter(color: TermTheme.of(context).color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TermWidget(term),
      ),
    );
  }
}

class _ParenthesisPainter extends CustomPainter {
  _ParenthesisPainter({@required this.color}) : assert(color != null);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      Path()
        // Left bracket.
        ..moveTo(16, 4)
        ..quadraticBezierTo(4, 0.2 * size.height, 4, size.height / 2)
        ..moveTo(16, size.height - 4)
        ..quadraticBezierTo(4, 0.8 * size.height, 4, size.height / 2)
        // Right bracket.
        ..moveTo(size.width - 16, 4)
        ..quadraticBezierTo(
            size.width - 4, 0.2 * size.height, size.width - 4, size.height / 2)
        ..moveTo(size.width - 16, size.height - 4)
        ..quadraticBezierTo(
            size.width - 4, 0.8 * size.height, size.width - 4, size.height / 2),
      Paint()
        ..color = color
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_ParenthesisPainter oldDelegate) =>
      oldDelegate.color != color;
}
