import 'package:flutter/material.dart';

class AnimatedContent extends StatefulWidget {
  const AnimatedContent({
    Key key,
    @required this.alignment,
    @required this.tag,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Alignment alignment;
  final Object tag;
  final Widget child;

  @override
  _AnimatedContentState createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<AnimatedContent>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _newChildScale;
  Animation<double> _newChildOpacity;

  Widget _oldChild;
  Animation<double> _oldChildScale;
  Animation<double> _oldChildOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    final appearCurve =
        CurveTween(curve: Curves.easeOutExpo).animate(_controller);
    _newChildScale = Tween<double>(begin: 4, end: 1).animate(appearCurve);
    _newChildOpacity = Tween<double>(begin: 0, end: 1).animate(appearCurve);
    final disappearCurve =
        CurveTween(curve: Curves.easeIn).animate(_controller);
    _oldChildScale = Tween<double>(begin: 1, end: 0.5).animate(disappearCurve);
    _oldChildOpacity = Tween<double>(begin: 1, end: -8).animate(disappearCurve);

    _controller.value = 1;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void didUpdateWidget(AnimatedContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tag != widget.tag) {
      _oldChild = oldWidget.child;
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment,
      children: <Widget>[
        if (_oldChild != null)
          ScaleTransition(
            scale: _oldChildScale,
            child: FadeTransition(
              opacity: _oldChildOpacity,
              child: _oldChild,
            ),
          ),
        ScaleTransition(
          scale: _newChildScale,
          child: FadeTransition(
            opacity: _newChildOpacity,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
