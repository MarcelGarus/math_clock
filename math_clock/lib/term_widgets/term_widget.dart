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
  const TermWidget({
    @required this.term,
    this.typesToParenthesise = const {},
  })  : assert(term != null),
        assert(typesToParenthesise != null);

  final Term term;
  Term get first => term.children.first;
  Term get second => term.children[1];

  final Set<Type> typesToParenthesise;

  @override
  Widget build(BuildContext context) {
    if (typesToParenthesise.contains(term.runtimeType)) {
      return ParenthesisWidget(term: term);
    }

    switch (term.runtimeType) {
      case Number:
        return NumberWidget(term: term);
      case Add:
        return AddWidget(term: term);
      case Subtract:
        return SubtractWidget(term: term);
      case Multiply:
        return MultiplyWidget(term: term);
      case Divide:
        return DivideWidget(term: term);
      case Modulo:
        return ModuloWidget(term: term);
      case Squared:
        return SquaredWidget(term: term);
      case Cubed:
        return CubedWidget(term: term);
      case Factorial:
        return FactorialWidget(term: term);
      case Root:
        return RootWidget(term: term);
      default:
        return Text('unknown type ${term.runtimeType}');
    }
  }
}
