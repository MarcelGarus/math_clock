import 'package:flutter/material.dart';
import 'package:math_clock/equation/theme.dart';

import '../math/math.dart';

part 'number.dart';
part 'brackets.dart';
part 'add.dart';
part 'subtract.dart';
part 'multiply.dart';
part 'divide.dart';
part 'modulo.dart';
part 'squared.dart';
part 'cubed.dart';
part 'root.dart';
part 'factorial.dart';

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
      child: DefaultTextStyle(
        style: TextStyle(
          color: color,
          fontSize: 64,
          fontWeight: FontWeight.w900,
        ),
        child: _MathNodeWidget(equation),
      ),
    );
  }
}

class _MathNodeWidget extends StatelessWidget {
  const _MathNodeWidget(this.node, {Key key}) : super(key: key);

  final MathNode node;
  MathNode get first => node.children.first;
  MathNode get second => node.children[1];

  @override
  Widget build(BuildContext context) {
    switch (node.runtimeType) {
      case Number:
        return _NumberWidget(node);
      case Add:
        return AddWidget(node);
      case Subtract:
        return _SubtractWidget(node);
      case Multiply:
        return _MultiplyWidget(node);
      case Divide:
        return _DivideWidget(node);
      case Modulo:
        return _ModuloWidget(node);
      case Squared:
        return _SquaredWidget(node);
      case Cubed:
        return _CubedWidget(node);
      case Factorial:
        return _FactorialWidget(node);
      case Root:
        return _RootWidget(node);
      default:
        return Text('unknown type ${node.runtimeType}');
    }
  }
}

Widget _bracketIfTypeOf(MathNode node, List<Type> typesToBracket) {
  return (typesToBracket.contains(node.runtimeType))
      ? _BracketsWidget(node)
      : _MathNodeWidget(node);
}
