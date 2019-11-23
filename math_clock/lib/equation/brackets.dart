part of 'equation.dart';

class _BracketsWidget extends _MathNodeWidget {
  const _BracketsWidget(MathNode node)
      : assert(node is! Number),
        super(node);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BracketsPainter(color: EquationTheme.of(context).color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _MathNodeWidget(node),
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
        ..moveTo(16, 0)
        ..quadraticBezierTo(4, 0.2 * size.height, 4, size.height / 2)
        ..moveTo(16, size.height)
        ..quadraticBezierTo(4, 0.8 * size.height, 4, size.height / 2)
        ..moveTo(size.width - 16, 0)
        ..quadraticBezierTo(
            size.width - 4, 0.2 * size.height, size.width - 4, size.height / 2)
        ..moveTo(size.width - 16, size.height)
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
