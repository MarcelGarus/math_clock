import 'dart:ui';

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

const _themes = [
  // Chocolate theme.
  MathClockThemeData(
    topBackground: Color(0xfff2dcd3),
    topForeground: Color(0xff85506e),
    bottomBackground: Color(0xff3b3638),
    bottomForeground: Color(0xffeed7db),
  ),
  // Mint theme.
  MathClockThemeData(
    topBackground: Color(0xffeff3fb),
    topForeground: Color(0xffd7784e),
    bottomBackground: Color(0xff232323),
    bottomForeground: Color(0xffbff3eb),
  ),
  // Dawn theme.
  MathClockThemeData(
    topBackground: Color(0xfffbdf99),
    topForeground: Color(0xff2e57ba),
    bottomBackground: Color(0xff02284c),
    bottomForeground: Color(0xfff6748c),
  ),
  // Android theme.
  MathClockThemeData(
    topBackground: Color(0xffffffff),
    topForeground: Color(0xff2dbb75),
    bottomBackground: Color(0xff073042),
    bottomForeground: Color(0xffeff7cf),
  ),
];

/// Generates a theme based on the time of day.
/// We just rotate and interpolate between all the different [_themes].
MathClockThemeData generateThemeByTime(DateTime now) {
  assert(now != null);

  const minutesPerDay = 24 * 60;
  final minutesThisDay = now.hour * 60 + now.minute;
  final themeIndex = _themes.length * minutesThisDay / minutesPerDay;

  final lastTheme = _themes[themeIndex.floor()];
  final nextTheme = _themes[(themeIndex.floor() + 1) % _themes.length];

  return MathClockThemeData.lerp(lastTheme, nextTheme, themeIndex % 1);
}
