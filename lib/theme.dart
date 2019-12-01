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
  // These are the Google (Cloud) colors. :D
  WeatherCondition.cloudy: MathClockThemeData(
    topBackground: Color(0xffffffff),
    topForeground: Color(0xff4285F4),
    topShadow: Color(0x660F9D58),
    bottomBackground: Color(0xfff0f0f0),
    bottomForeground: Color(0xffDB4437),
    bottomShadow: Color(0xffF4B400),
  ),
  WeatherCondition.foggy: MathClockThemeData(
    topBackground: Color(0xfffffcfc),
    topForeground: Color(0xfffcbbb1),
    topShadow: Color(0xff8F6F7A),
    bottomBackground: Color(0xffFEDAA5),
    bottomForeground: Color(0xff91715E),
    bottomShadow: Color(0xffE6B395),
  ),
  WeatherCondition.rainy: MathClockThemeData(
    topBackground: Color(0xff375EB3),
    topForeground: Color(0xffffffff),
    topShadow: Color(0xff293C47),
    bottomBackground: Color(0xff4F87FF),
    bottomForeground: Color(0xffffffff),
    bottomShadow: Color(0xff1B1B45),
  ),
  WeatherCondition.snowy: MathClockThemeData(
    topBackground: Color(0xffffffff),
    topForeground: Color(0xff4389E8),
    topShadow: Color(0xffd8edfc),
    bottomBackground: Color(0xff98ddfc),
    bottomForeground: Color(0xffffffff),
    bottomShadow: Color(0xff4389E8),
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
    topForeground: Color(0xffd7784e),
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
