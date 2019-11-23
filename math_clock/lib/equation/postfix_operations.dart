import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'math_node_widget.dart';
import 'tight_text.dart';

class _PostfixOperationWidget extends MathNodeWidget {
  const _PostfixOperationWidget(
    MathNode node,
    this.operation, {
    this.typesToBracket = const [],
  })  : assert(operation != null),
        assert(typesToBracket != null),
        super(node);

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
  const SquaredWidget(Squared node)
      : super(node, '²', typesToBracket: const [..._lowerOrderOperands, Cubed]);
}

class CubedWidget extends _PostfixOperationWidget {
  const CubedWidget(Cubed node)
      : super(node, '³',
            typesToBracket: const [..._lowerOrderOperands, Squared]);
}

class FactorialWidget extends _PostfixOperationWidget {
  const FactorialWidget(Factorial node)
      : super(node, '!', typesToBracket: _lowerOrderOperands);
}
