/*
class _MathClockState extends State<MathClock> {
  Term _hourTerm;
  Term _minuteTerm;
  bool _ready = false;
  WeatherCondition _weather;

  void _updateHour() => _hourTerm = generateMathTerm(widget.now.hour);
  void _updateMinute() => _minuteTerm = generateMathTerm(widget.now.minute);

  @override
  void initState() {
    super.initState();

    _updateHour();
    _updateMinute();

    () async {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _ready = true;
        _weather = WeatherCondition.sunny;
        _hourTerm =
            Root(Subtract(Factorial(Number(3)), Modulo(Number(14), Number(3))));
        _minuteTerm = Subtract(Multiply(Number(17), Number(3)), Number(14));
      });
      print(_ready);
      await Future.delayed(Duration(seconds: 6));
      setState(() => _minuteTerm = Subtract(Number(62), Factorial(Number(4))));
      await Future.delayed(Duration(milliseconds: 4700));
      setState(() => _minuteTerm = Multiply(Root(Number(9)), Number(13)));
      await Future.delayed(Duration(milliseconds: 300));
      setState(() => _weather = WeatherCondition.windy);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _weather = WeatherCondition.snowy);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _weather = WeatherCondition.foggy);
      await Future.delayed(Duration(milliseconds: 1600));
      setState(() => _minuteTerm =
          Multiply(Modulo(Number(58), Number(10)), Root(Number(25))));
      await Future.delayed(Duration(milliseconds: 400));
      setState(() => _weather = WeatherCondition.thunderstorm);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _weather = WeatherCondition.cloudy);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _ready = false);
    }();
  }

  @override
  void didUpdateWidget(MathClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    //if (oldWidget.now.hour != widget.now.hour) setState(_updateHour);
    //if (oldWidget.now.minute != widget.now.minute) setState(_updateMinute);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return Container(color: Colors.red);
    return MathClockTheme.fromWeather(
      weather: _weather,
      child: MathClockDisplay(
        hourTerm: _hourTerm,
        minuteTerm: _minuteTerm,
      ),
    );
  }
}
*/
