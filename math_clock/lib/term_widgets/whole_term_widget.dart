import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'theme.dart';

/// A widget that displays the [term] in the [color].
class WholeTermWidget extends StatelessWidget {
  const WholeTermWidget(
    this.term, {
    @required this.color,
  })  : assert(term != null),
        assert(color != null);

  final Term term;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TermTheme(
      data: TermThemeData(color: color),
      child: TermWidget(term),
    );
  }
}
