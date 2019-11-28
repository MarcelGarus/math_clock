import 'dart:ui';

import 'package:flutter_clock_helper/model.dart';
import 'package:meta/meta.dart';

@immutable
class MathClockThemeData {
  const MathClockThemeData({
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

  /// Linearly interpolate between two [MathClockThemeData].
  ///
  /// The [t] argument represents the position on the timeline, with 0.0
  /// meaning that the interpolation has not started, returning [a] (or
  /// something equivalent to [a]), 1.0 meaning that the interpolation has
  /// finished, returning [b] (or something equivalent to [b]), and values in
  /// between meaning that the interpolation is at the relevant point on the
  /// timeline between [a] and [b].
  static MathClockThemeData lerp(
    MathClockThemeData a,
    MathClockThemeData b,
    double t,
  ) {
    assert(t != null);
    assert(a != null);
    assert(b != null);

    return MathClockThemeData(
      topBackground: Color.lerp(a.topBackground, b.topBackground, t),
      topForeground: Color.lerp(a.topForeground, b.topForeground, t),
      bottomBackground: Color.lerp(a.bottomBackground, b.bottomBackground, t),
      bottomForeground: Color.lerp(a.bottomForeground, b.bottomForeground, t),
    );
  }
}

// Weather is either: cloudy, foggy, rainy, snowy, sunny, thunderstorm, windy
const pinkChaiTheme = MathClockThemeData(
  topBackground: Color(0xfff2dcd3),
  topForeground: Color(0xff3b3638),
  bottomBackground: Color(0xff85506e),
  bottomForeground: Color(0xffeed7db),
);
const redGreenTheme = MathClockThemeData(
  topBackground: Color(0xfffadae2),
  topForeground: Color(0xffc8838b),
  bottomBackground: Color(0xff22aa8d),
  bottomForeground: Color(0xffbff3eb),
);
const dawnTheme = MathClockThemeData(
  topBackground: Color(0xffeba559),
  topForeground: Color(0xff2e57ba),
  bottomBackground: Color(0xff02284c),
  bottomForeground: Color(0xffe6546c),
);
const androidTheme = MathClockThemeData(
  topBackground: Color(0xffffffff),
  topForeground: Color(0xff3ddb85),
  bottomBackground: Color(0xff073042),
  bottomForeground: Color(0xffeff7cf),
);

const themes = [
  pinkChaiTheme,
  redGreenTheme,
  dawnTheme,
  androidTheme,
];

MathClockThemeData generateThemeByTime(int hour, int minute) {
  const minutesPerDay = 24 * 60;
  final minutesThisDay = hour * 60 + minute;
  final themeIndex = themes.length * minutesThisDay / minutesPerDay;

  final lastTheme = themes[themeIndex.floor()];
  final nextTheme = themes[(themeIndex.floor() + 1) % themes.length];

  return MathClockThemeData.lerp(lastTheme, nextTheme, themeIndex % 1);
}

const themesByWeather = <WeatherCondition, MathClockThemeData>{
  WeatherCondition.cloudy: androidTheme,
  WeatherCondition.foggy: redGreenTheme,
  WeatherCondition.rainy: androidTheme,
  WeatherCondition.snowy: androidTheme,
  WeatherCondition.sunny: dawnTheme,
  WeatherCondition.thunderstorm: androidTheme,
  WeatherCondition.windy: androidTheme,
};
