import 'package:flutter/material.dart';

class SlantedLayout extends StatelessWidget {
  const SlantedLayout({
    Key key,
    this.top,
    this.bottom,
    this.primaryColor,
    this.secondaryColor,
  })  : assert(top != null),
        assert(bottom != null),
        assert(primaryColor != null),
        assert(secondaryColor != null),
        super(key: key);

  final Widget top;
  final Widget bottom;
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
        _buildContent(true),
        _buildContent(false),
      ],
    );
  }

  Widget _buildContent(bool isTop) {
    return ClipPath(
      clipper: isTop ? _TopSlantClipper() : _BottomSlantClipper(),
      child: Container(
        width: 500,
        height: 300,
        alignment: isTop ? Alignment.topLeft : Alignment.bottomRight,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Transform.rotate(
          angle: -0.2,
          child: Container(
            width: 450,
            height: 100,
            alignment: isTop ? Alignment.bottomLeft : Alignment.topRight,
            child: isTop ? top : bottom,
          ),
        ),
      ),
    );
  }
}

class _TopSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 200)
      ..lineTo(500, 100)
      ..lineTo(500, 0)
      ..lineTo(0, 0);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class _BottomSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 200)
      ..lineTo(500, 100)
      ..lineTo(500, 300)
      ..lineTo(0, 300);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
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
        _BottomSlantClipper().getClip(size),
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
