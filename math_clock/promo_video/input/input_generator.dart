/*
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
  bool _ready = false;

  void _updateHour() => _hourTerm = generateMathTerm(widget.hour);
  void _updateMinute() => _minuteTerm = generateMathTerm(widget.minute);

  @override
  void initState() {
    super.initState();

    _updateHour();
    _updateMinute();

    // Promo video stuff. Because the promo video is only 30 seconds, we need
// to hurry and display terms more rapidly. Also, we hardcoded beautiful
// terms that don't occlude the camera during transitions.
    Future.microtask(() async {
      // Video synchronization.
      setState(() => _ready = false);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _ready = true);

      // Introduction.
      // 16:37
      setState(() {
        _hourTerm =
            Root(Subtract(Factorial(Number(3)), Modulo(Number(14), Number(3))));
        _minuteTerm = Subtract(Multiply(Number(17), Number(3)), Number(14));
      });
      await Future.delayed(Duration(seconds: 8));

      // Currently zooming in on the clock.
      // 16:38
      setState(() => _minuteTerm = Subtract(Number(62), Factorial(Number(4))));
      await Future.delayed(Duration(seconds: 2));

      // Zooming out again while changing through themes.
      // 16:39
      await Future.delayed(Duration(seconds: 3));
      setState(() => _minuteTerm = Multiply(Root(Number(9)), Number(13)));
      await Future.delayed(Duration(seconds: 5));
      // 16:40
      setState(() => _minuteTerm =
          Multiply(Modulo(Number(58), Number(10)), Root(Number(25))));

      await Future.delayed(Duration(seconds: 10));
      setState(() => _ready = false);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _ready = true);
    });
  }

  @override
  void didUpdateWidget(MathClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    //if (oldWidget.hour != widget.hour) setState(_updateHour);
    //if (oldWidget.minute != widget.minute) setState(_updateMinute);
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

    final theme = dawnTheme;

    if (!_ready) return Container(color: Colors.red);
    return MathClockDisplay(
      theme: theme,
      hourTerm: _hourTerm,
      minuteTerm: _minuteTerm,
    );
  }
}
*/
