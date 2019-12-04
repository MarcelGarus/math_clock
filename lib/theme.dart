import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:meta/meta.dart';

@immutable
class MathClockThemeData {
  const MathClockThemeData({
    @required this.topBackground,
    @required this.topForeground,
    this.topShadow,
    @required this.bottomBackground,
    @required this.bottomForeground,
    this.bottomShadow,
  })  : assert(topBackground != null),
        assert(topForeground != null),
        assert(bottomBackground != null),
        assert(bottomForeground != null);

  final Color topBackground;
  final Color topForeground;
  final Color topShadow;
  final Color bottomBackground;
  final Color bottomForeground;
  final Color bottomShadow;
}

const _themesByWeather = {
  WeatherCondition.cloudy: MathClockThemeData(
    topBackground: Color(0xffffffff),
    topForeground: Color(0xff3172e2),
    topShadow: Color(0x660f9d58),
    bottomBackground: Color(0xfff0f0f0),
    bottomForeground: Color(0xffbb3427),
    bottomShadow: Color(0xfff4b400),
  ),
  WeatherCondition.foggy: MathClockThemeData(
    topBackground: Color(0xfffffcfc),
    topForeground: Color(0xfffcbbb1),
    topShadow: Color(0xff8f5f6a),
    bottomBackground: Color(0xfffedaa5),
    bottomForeground: Color(0xff79583e),
    bottomShadow: Color(0xffe6b395),
  ),
  WeatherCondition.rainy: MathClockThemeData(
    topBackground: Color(0xff2f4d9b),
    topForeground: Color(0xffffffff),
    topShadow: Color(0xff293c47),
    bottomBackground: Color(0xff3f67cf),
    bottomForeground: Color(0xffffffff),
    bottomShadow: Color(0xff1b1b45),
  ),
  WeatherCondition.snowy: MathClockThemeData(
    topBackground: Color(0xffffffff),
    topForeground: Color(0xff5F9ED7),
    topShadow: Color(0xffd8edfc),
    bottomBackground: Color(0xff5F9ED7),
    bottomForeground: Color(0xffffffff),
    bottomShadow: Color(0xff2379C8),
  ),
  WeatherCondition.sunny: MathClockThemeData(
    topBackground: Color(0xfffbdf99),
    topForeground: Color(0xff2e57ba),
    topShadow: Colors.black12,
    bottomBackground: Color(0xff02284c),
    bottomForeground: Color(0xfff6748c),
    bottomShadow: Colors.white12,
  ),
  WeatherCondition.thunderstorm: MathClockThemeData(
    topBackground: Color(0xff02284c),
    topForeground: Color(0xffffffee),
    topShadow: Color(0xfff6748c),
    bottomBackground: Color(0xff000000),
    bottomForeground: Color(0xfff6748c),
    bottomShadow: Color(0xff62486c),
  ),
  WeatherCondition.windy: MathClockThemeData(
    topBackground: Color(0xffeff3fb),
    topForeground: Color(0xffa7582e),
    topShadow: Color(0xffe7dcce),
    bottomBackground: Color(0xff232323),
    bottomForeground: Color(0xffbff3eb),
  ),
};

class MathClockTheme extends InheritedWidget {
  const MathClockTheme({
    @required this.data,
    @required Widget child,
  })  : assert(data != null),
        super(child: child);

  MathClockTheme.fromWeather({
    @required WeatherCondition weather,
    @required Widget child,
  }) : this(data: _themesByWeather[weather], child: child);

  final MathClockThemeData data;

  static MathClockThemeData of(BuildContext context) {
    final inheritedTheme =
        context.inheritFromWidgetOfExactType(MathClockTheme) as MathClockTheme;
    return inheritedTheme?.data;
  }

  @override
  bool updateShouldNotify(MathClockTheme oldWidget) => oldWidget.data != data;
}
