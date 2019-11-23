import 'package:flutter/material.dart';
import 'package:math_clock/animated_equation.dart';
import 'package:math_clock/math/math.dart';

import 'term_widgets/term_widget.dart';
import 'slanted_layout/slanted_layout.dart';

class MathClock extends StatefulWidget {
  const MathClock({Key key, @required this.hour, @required this.minute})
      : assert(hour != null),
        assert(minute != null),
        super(key: key);

  final int hour;
  final int minute;

  @override
  _MathClockState createState() => _MathClockState();
}

class _MathClockState extends State<MathClock> {
  Term _hourTerm;
  Term _minuteTerm;

  void _updateHour() => _hourTerm = generateMathTerm(widget.hour);
  void _updateMinute() => _minuteTerm = generateMathTerm(widget.minute);

  @override
  void initState() {
    super.initState();

    _updateHour();
    _updateMinute();
  }

  @override
  void didUpdateWidget(MathClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.hour != widget.hour) setState(_updateHour);
    if (oldWidget.minute != widget.minute) setState(_updateMinute);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.white; //Colors.yellowAccent;
    final secondaryColor =
        Colors.black; //Color.lerp(Colors.deepPurple, Colors.black, 0.4);

    return FittedBox(
      child: Container(
        width: 500,
        height: 300,
        alignment: Alignment.center,
        child: SlantedLayout(
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          top: AnimatedClockContent(
            alignment: Alignment.bottomLeft,
            tag: _hourTerm,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TermTheme(
                data: TermThemeData(color: secondaryColor),
                child: TermWidget(_hourTerm),
              ),
            ),
          ),
          bottom: AnimatedClockContent(
            alignment: Alignment.topRight,
            tag: _minuteTerm,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TermTheme(
                data: TermThemeData(color: primaryColor),
                child: TermWidget(_minuteTerm),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
