import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'binary_operations.dart';
import 'brackets.dart';
import 'number.dart';
import 'root.dart';
import 'postfix_operations.dart';

class MathNodeWidget extends StatelessWidget {
  const MathNodeWidget(this.node, {Key key}) : super(key: key);

  final MathNode node;
  MathNode get first => node.children.first;
  MathNode get second => node.children[1];

  @override
  Widget build(BuildContext context) {
    switch (node.runtimeType) {
      case Number:
        return NumberWidget(node);
      case Add:
        return AddWidget(node);
      case Subtract:
        return SubtractWidget(node);
      case Multiply:
        return MultiplyWidget(node);
      case Divide:
        return DivideWidget(node);
      case Modulo:
        return ModuloWidget(node);
      case Squared:
        return SquaredWidget(node);
      case Cubed:
        return CubedWidget(node);
      case Factorial:
        return FactorialWidget(node);
      case Root:
        return RootWidget(node);
      default:
        return Text('unknown type ${node.runtimeType}');
    }
  }
}

Widget bracketIfTypeOf(MathNode node, List<Type> typesToBracket) {
  return (typesToBracket.contains(node.runtimeType))
      ? BracketsWidget(node)
      : MathNodeWidget(node);
}
