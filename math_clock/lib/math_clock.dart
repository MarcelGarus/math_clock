import 'package:flutter/material.dart';
import 'package:math_clock/animated_content.dart';
import 'package:math_clock/math/math.dart';

import 'term_widgets/term_widget.dart';
import 'slanted_layout/slanted_layout.dart';

@immutable
class MathClockThemeData {
  MathClockThemeData({
    this.topBackground,
    this.topForeground,
    this.bottomBackground,
    this.bottomForeground,
  })  : assert(topBackground != null),
        assert(topForeground != null),
        assert(bottomBackground != null),
        assert(bottomForeground != null);

  final Color topBackground;
  final Color topForeground;
  final Color bottomBackground;
  final Color bottomForeground;
}

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
    // Weather is either: cloudy, foggy, rainy, snowy, sunny, thunderstorm, windy
    final pinkChaiTheme = MathClockThemeData(
      topBackground: Color(0xfff2dcd3),
      topForeground: Color(0xff3b3638),
      bottomBackground: Color(0xff85506e),
      bottomForeground: Color(0xffeed7db),
    );
    final redGreenTheme = MathClockThemeData(
      topBackground: Color(0xfffadae2),
      topForeground: Color(0xffc8838b),
      bottomBackground: Color(0xff22aa8d),
      bottomForeground: Color(0xffbff3eb),
    );
    final dawnTheme = MathClockThemeData(
      topBackground: Color(0xffeba559),
      topForeground: Color(0xff2e57ba),
      bottomBackground: Color(0xff02284c),
      bottomForeground: Color(0xffe6546c),
    );
    final androidTheme = MathClockThemeData(
      topBackground: Color(0xffffffff),
      topForeground: Color(0xff3ddb85),
      bottomBackground: Color(0xff073042),
      bottomForeground: Color(0xffeff7cf),
    );

    final theme = redGreenTheme;

    return MathClockDisplay(
      theme: theme,
      hourTerm: _hourTerm,
      minuteTerm: _minuteTerm,
    );
  }
}

class MathClockDisplay extends StatelessWidget {
  const MathClockDisplay({
    Key key,
    @required this.theme,
    @required this.hourTerm,
    @required this.minuteTerm,
  })  : assert(theme != null),
        assert(hourTerm != null),
        assert(minuteTerm != null),
        super(key: key);

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
              child: TermTheme(
                data: TermThemeData(color: theme.topForeground),
                child: TermWidget(hourTerm),
              ),
            ),
          ),
          bottom: AnimatedContent(
            alignment: Alignment.topRight,
            tag: minuteTerm,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TermTheme(
                data: TermThemeData(color: theme.bottomForeground),
                child: TermWidget(minuteTerm),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
