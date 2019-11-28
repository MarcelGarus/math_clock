import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'binary_operations.dart';
import 'parenthesis.dart';
import 'number.dart';
import 'root.dart';
import 'postfix_operations.dart';

export 'theme.dart';

/// A widget that displays the given [term].
/// Optionally, you can also provide a set of [typesToParenthesise]. If the
/// widget's runtime type is included into the [typesToParenthesise], the term
/// is wrapped in a [ParenthesisWidget].
class TermWidget extends StatelessWidget {
  const TermWidget(
    this.term, {
    this.typesToParenthesise = const {},
  }) : assert(typesToParenthesise != null);

  final Term term;
  Term get first => term.children.first;
  Term get second => term.children[1];

  final Set<Type> typesToParenthesise;

  @override
  Widget build(BuildContext context) {
    if (typesToParenthesise.contains(term.runtimeType)) {
      return ParenthesisWidget(term);
    }

    switch (term.runtimeType) {
      case Number:
        return NumberWidget(term);
      case Add:
        return AddWidget(term);
      case Subtract:
        return SubtractWidget(term);
      case Multiply:
        return MultiplyWidget(term);
      case Divide:
        return DivideWidget(term);
      case Modulo:
        return ModuloWidget(term);
      case Squared:
        return SquaredWidget(term);
      case Cubed:
        return CubedWidget(term);
      case Factorial:
        return FactorialWidget(term);
      case Root:
        return RootWidget(term);
      default:
        return Text('unknown type ${term.runtimeType}');
    }
  }
}
