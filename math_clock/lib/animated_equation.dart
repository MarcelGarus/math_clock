import 'package:flutter/material.dart';

class AnimatedClockContent extends StatefulWidget {
  const AnimatedClockContent({
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
  _AnimatedClockContentState createState() => _AnimatedClockContentState();
}

class _AnimatedClockContentState extends State<AnimatedClockContent>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _newChildScale;

  Widget _oldChild;
  Animation<double> _oldChildScale;
  Animation<double> _oldChildOpacity;

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _startAnimation(widget.child);
  }

  void didUpdateWidget(AnimatedClockContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tag != widget.tag) {
      _startAnimation(widget.child);
    }
  }

  void _startAnimation(Widget newChild) {
    _controller.reset();
    _controller.forward().then((_) => _oldChild = newChild);
    var appearCurve =
        CurveTween(curve: Curves.easeOutExpo).animate(_controller);
    _newChildScale = Tween<double>(begin: 100, end: 1).animate(appearCurve);
    var disappearCurve = CurveTween(curve: Curves.easeIn).animate(_controller);
    _oldChildScale = Tween<double>(begin: 1, end: 0.5).animate(disappearCurve);
    _oldChildOpacity = Tween<double>(begin: 1, end: -2).animate(disappearCurve);
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
          child: widget.child,
        ),
      ],
    );
  }
}
