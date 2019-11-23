import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'math_node_widget.dart';
import 'theme.dart';

class Equation extends StatelessWidget {
  const Equation(this.equation, {Key key, this.color})
      : assert(equation != null),
        assert(color != null),
        super(key: key);

  final MathNode equation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return EquationTheme(
      data: EquationThemeData(color: color),
      child: MathNodeWidget(equation),
    );
  }
}
