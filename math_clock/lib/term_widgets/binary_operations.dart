import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'tight_text.dart';

class _BinaryOperationWidget extends TermWidget {
  const _BinaryOperationWidget(
    Term term,
    this.operation, {
    this.typesOfFirstToBracket = const [],
    this.typesOfSecondToBracket = const [],
  })  : assert(operation != null),
        assert(typesOfFirstToBracket != null),
        assert(typesOfSecondToBracket != null),
        super(term);

  final String operation;
  final List<Type> typesOfFirstToBracket;
  final List<Type> typesOfSecondToBracket;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        bracketIfTypeOf(first, typesOfFirstToBracket),
        SizedBox(width: 8),
        TightText(operation),
        SizedBox(width: 8),
        bracketIfTypeOf(second, typesOfSecondToBracket),
      ],
    );
  }
}

class AddWidget extends _BinaryOperationWidget {
  const AddWidget(Add term) : super(term, '+');
}

class SubtractWidget extends _BinaryOperationWidget {
  const SubtractWidget(Subtract term)
      : super(term, '-', typesOfSecondToBracket: const [Add]);
}

class MultiplyWidget extends _BinaryOperationWidget {
  const MultiplyWidget(Multiply term)
      : super(term, '×',
            typesOfFirstToBracket: const [Add, Subtract, Modulo],
            typesOfSecondToBracket: const [Add, Subtract, Modulo]);
}

class DivideWidget extends _BinaryOperationWidget {
  const DivideWidget(Divide term)
      : super(term, '/',
            typesOfFirstToBracket: const [Add, Subtract, Modulo],
            typesOfSecondToBracket: const [Add, Subtract, Multiply, Modulo]);
}

class ModuloWidget extends _BinaryOperationWidget {
  const ModuloWidget(Modulo term)
      : super(term, '%',
            typesOfFirstToBracket: const [Add, Subtract, Multiply, Divide],
            typesOfSecondToBracket: const [Add, Subtract, Multiply, Divide]);
}
