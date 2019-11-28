import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'tight_text.dart';

/// Displays a postfix operation.
///
/// All postfix operations display the operand and behind it, the operation
/// ifself. This widget makes it easy to render such a widget:
/// You simply provide a [term] with a single child and the text of the
/// [operation] itself.
/// Also, you have the option to provide a collection of types that should be
/// put in parenthesis for the operand. If the operand is of one of the given
/// types, a bracket (that's the "(" and ")" parenthesises) are rendered around
/// the term.
class _PostfixOperationWidget extends TermWidget {
  const _PostfixOperationWidget({
    @required Term term,
    @required this.operation,
    this.typesToParenthesise = const {},
  })  : assert(term != null),
        assert(operation != null),
        assert(typesToParenthesise != null),
        super(term);

  final String operation;
  final Set<Type> typesToParenthesise;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TermWidget(first, typesToParenthesise: typesToParenthesise),
        TightText(operation),
      ],
    );
  }
}

const _lowerOrderOperands = {Add, Subtract, Multiply, Divide, Modulo};

class SquaredWidget extends _PostfixOperationWidget {
  const SquaredWidget(Squared term)
      : super(
          term: term,
          operation: '²',
          typesToParenthesise: const {..._lowerOrderOperands, Cubed},
        );
}

class CubedWidget extends _PostfixOperationWidget {
  const CubedWidget(Cubed term)
      : super(
          term: term,
          operation: '³',
          typesToParenthesise: const {..._lowerOrderOperands, Squared},
        );
}

class FactorialWidget extends _PostfixOperationWidget {
  const FactorialWidget(Factorial term)
      : super(
          term: term,
          operation: '!',
          typesToParenthesise: _lowerOrderOperands,
        );
}
