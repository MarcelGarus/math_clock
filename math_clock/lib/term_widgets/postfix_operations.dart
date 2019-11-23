import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'tight_text.dart';

/// Renders a term which is a postfix operation (something just written after
/// the operand), like x², x³ or x!.
class _PostfixOperationWidget extends TermWidget {
  const _PostfixOperationWidget(
    Term term,
    this.operation, {
    Key key,
    this.typesToBracket = const [],
  })  : assert(operation != null),
        assert(typesToBracket != null),
        super(term, key: key);

  final String operation;
  final List<Type> typesToBracket;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        bracketIfTypeOf(first, typesToBracket),
        TightText(operation),
      ],
    );
  }
}

const _lowerOrderOperands = [Add, Subtract, Multiply, Divide, Modulo];

class SquaredWidget extends _PostfixOperationWidget {
  const SquaredWidget(Squared term)
      : super(term, '²', typesToBracket: const [..._lowerOrderOperands, Cubed]);
}

class CubedWidget extends _PostfixOperationWidget {
  const CubedWidget(Cubed term)
      : super(term, '³',
            typesToBracket: const [..._lowerOrderOperands, Squared]);
}

class FactorialWidget extends _PostfixOperationWidget {
  const FactorialWidget(Factorial term)
      : super(term, '!', typesToBracket: _lowerOrderOperands);
}
