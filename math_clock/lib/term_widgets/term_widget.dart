import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'binary_operations.dart';
import 'brackets.dart';
import 'number.dart';
import 'root.dart';
import 'postfix_operations.dart';

export 'theme.dart';

/// A widget that displays the given [term].
class TermWidget extends StatelessWidget {
  const TermWidget(this.term, {Key key}) : super(key: key);

  final Term term;
  Term get first => term.children.first;
  Term get second => term.children[1];

  @override
  Widget build(BuildContext context) {
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

/// Returns a widget that renders the given [term].
///
/// If the [term]'s runtime type is included in the list of [typesToBracket],
/// puts the term into a [BracketsWidget].
Widget bracketIfTypeOf(Term term, List<Type> typesToBracket) {
  return (typesToBracket.contains(term.runtimeType))
      ? BracketsWidget(term)
      : TermWidget(term);
}
