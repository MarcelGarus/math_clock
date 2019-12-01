import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'theme.dart';

/// A widget that displays the [term] in the [color].
class ShadowedTermWidget extends StatelessWidget {
  const ShadowedTermWidget({
    @required this.term,
    @required this.color,
    @required this.shadowColor,
  })  : assert(term != null),
        assert(color != null);

  final Term term;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (shadowColor != null)
          Transform.translate(
            offset: Offset(3, 3),
            child: TermTheme(
              data: TermThemeData(color: shadowColor),
              child: TermWidget(term: term),
            ),
          ),
        TermTheme(
          data: TermThemeData(color: color),
          child: TermWidget(term: term),
        ),
      ],
    );
  }
}
