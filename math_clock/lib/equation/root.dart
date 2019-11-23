part of 'equation.dart';

class _RootWidget extends _MathNodeWidget {
  const _RootWidget(Root node) : super(node);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RootPainter(color: EquationTheme.of(context).color),
      child: Padding(
        padding: const EdgeInsets.only(left: 38, top: 12, right: 12),
        child: _MathNodeWidget(first),
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
        ..lineTo(20, size.height)
        ..lineTo(30, 0)
        ..lineTo(size.width - 4, 0)
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
