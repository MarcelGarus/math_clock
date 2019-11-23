import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'theme.dart';

/// Displays brackets (that's "(" and ")") around the given [term].
class BracketsWidget extends TermWidget {
  const BracketsWidget(Term term, {Key key})
      : assert(term is! Number), // Numbers should never be put in brackets.
        super(term, key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BracketsPainter(color: TermTheme.of(context).color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TermWidget(term),
      ),
    );
  }
}

class _BracketsPainter extends CustomPainter {
  _BracketsPainter({@required this.color}) : assert(color != null);

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
  bool shouldRepaint(_BracketsPainter oldDelegate) =>
      oldDelegate.color != color;
}
