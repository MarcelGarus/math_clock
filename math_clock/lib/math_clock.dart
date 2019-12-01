import 'package:flutter/material.dart';
import 'package:math_clock/animated_content.dart';
import 'package:math_clock/math/math.dart';
import 'package:math_clock/theme.dart';

import 'term_widgets/shadowed_term_widget.dart';
import 'slanted_layout/slanted_layout.dart';

class MathClock extends StatefulWidget {
  const MathClock({@required this.now}) : assert(now != null);

  final DateTime now;

  @override
  _MathClockState createState() => _MathClockState();
}

class _MathClockState extends State<MathClock> {
  Term _hourTerm;
  Term _minuteTerm;

  void _updateHour() => _hourTerm = generateMathTerm(widget.now.hour);
  void _updateMinute() => _minuteTerm = generateMathTerm(widget.now.minute);

  @override
  void initState() {
    super.initState();

    _updateHour();
    _updateMinute();
  }

  @override
  void didUpdateWidget(MathClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.now.hour != widget.now.hour) setState(_updateHour);
    if (oldWidget.now.minute != widget.now.minute) setState(_updateMinute);
  }

  @override
  Widget build(BuildContext context) {
    return MathClockDisplay(
      theme: generateThemeByTime(widget.now),
      hourTerm: _hourTerm,
      minuteTerm: _minuteTerm,
    );
  }
}

class MathClockDisplay extends StatelessWidget {
  const MathClockDisplay({
    @required this.theme,
    @required this.hourTerm,
    @required this.minuteTerm,
  })  : assert(theme != null),
        assert(hourTerm != null),
        assert(minuteTerm != null);

  final MathClockThemeData theme;
  final Term hourTerm;
  final Term minuteTerm;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 500,
        height: 300,
        alignment: Alignment.center,
        child: SlantedLayout(
          topColor: theme.topBackground,
          bottomColor: theme.bottomBackground,
          top: AnimatedContent(
            alignment: Alignment.bottomLeft,
            tag: hourTerm,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ShadowedTermWidget(
                term: hourTerm,
                color: theme.topForeground,
                shadowColor: Colors.black12,
              ),
            ),
          ),
          bottom: AnimatedContent(
            alignment: Alignment.topRight,
            tag: minuteTerm,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ShadowedTermWidget(
                term: minuteTerm,
                color: theme.bottomForeground,
                shadowColor: Colors.white24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
