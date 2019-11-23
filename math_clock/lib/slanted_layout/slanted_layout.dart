import 'package:flutter/material.dart';
import 'package:math_clock/equation/equation.dart';
import 'package:math_clock/math/math.dart';

class SlantedLayout extends StatelessWidget {
  const SlantedLayout({
    Key key,
    this.hour,
    this.minute,
    this.primaryColor,
    this.secondaryColor,
  })  : assert(hour != null),
        assert(minute != null),
        assert(primaryColor != null),
        assert(secondaryColor != null),
        super(key: key);

  final MathNode hour;
  final MathNode minute;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _SlantedBackgroundPainter(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: -20,
          child: Transform.rotate(
            angle: -0.2,
            child: Container(
              width: 400,
              height: 150,
              alignment: Alignment.bottomLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Equation(hour, color: secondaryColor),
              ),
            ),
          ),
        ),
        Positioned(
          right: 40,
          bottom: -20,
          child: Transform.rotate(
            angle: -0.2,
            child: Transform.scale(
              scale: 1,
              child: Container(
                width: 400,
                height: 150,
                alignment: Alignment.topRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Equation(minute, color: primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SlantedBackgroundPainter extends CustomPainter {
  _SlantedBackgroundPainter({
    @required this.primaryColor,
    @required this.secondaryColor,
  })  : assert(primaryColor != null),
        assert(secondaryColor != null);

  final Color primaryColor;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = primaryColor,
      )
      ..drawPath(
        Path()
          ..moveTo(0, 200)
          ..lineTo(500, 100)
          ..lineTo(500, 300)
          ..lineTo(0, 300),
        Paint()..color = secondaryColor,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return !(oldDelegate is _SlantedBackgroundPainter &&
        oldDelegate.primaryColor == primaryColor &&
        oldDelegate.secondaryColor == secondaryColor);
  }
}
