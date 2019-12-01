/// All the widgets for displaying binary operations.

import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'tight_text.dart';

/// Displays a binary operation.
///
/// All binary operations display the first operand on the left, then the
/// operation itself and finally the second operand on the right. This widget
/// makes it easy to render such a widget:
/// You simply provide a [term] that has two children and the text of the
/// [operation] itself.
/// Also, you have the option to provide a collection of types that should be
/// put in parenthesis for the first and second operand. If an operand is of
/// one of the types that are given, parenthesis (that's the "(" and ")")
/// are rendered around the term.
class _BinaryOperationWidget extends TermWidget {
  const _BinaryOperationWidget({
    @required Term term,
    @required this.operation,
    this.typesOfFirstToParenthesise = const {},
    this.typesOfSecondToParenthesise = const {},
  })  : assert(term != null),
        assert(operation != null),
        assert(typesOfFirstToParenthesise != null),
        assert(typesOfSecondToParenthesise != null),
        super(term: term);

  final String operation;
  final Set<Type> typesOfFirstToParenthesise;
  final Set<Type> typesOfSecondToParenthesise;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TermWidget(
          term: first,
          typesToParenthesise: typesOfFirstToParenthesise,
        ),
        SizedBox(width: 8),
        TightText(operation),
        SizedBox(width: 8),
        TermWidget(
          term: second,
          typesToParenthesise: typesOfSecondToParenthesise,
        ),
      ],
    );
  }
}

class AddWidget extends _BinaryOperationWidget {
  const AddWidget({@required Add term}) : super(term: term, operation: '+');
}

class SubtractWidget extends _BinaryOperationWidget {
  const SubtractWidget({@required Subtract term})
      : super(
          term: term,
          operation: '-',
          typesOfSecondToParenthesise: const {Add},
        );
}

class MultiplyWidget extends _BinaryOperationWidget {
  const MultiplyWidget({@required Multiply term})
      : super(
          term: term,
          operation: '×',
          typesOfFirstToParenthesise: const {Add, Subtract, Modulo},
          typesOfSecondToParenthesise: const {Add, Subtract, Modulo},
        );
}

class DivideWidget extends _BinaryOperationWidget {
  const DivideWidget({@required Divide term})
      : super(
          term: term,
          operation: '/',
          typesOfFirstToParenthesise: const {Add, Subtract, Modulo},
          typesOfSecondToParenthesise: const {Add, Subtract, Multiply, Modulo},
        );
}

class ModuloWidget extends _BinaryOperationWidget {
  const ModuloWidget({@required Modulo term})
      : super(
          term: term,
          operation: '%',
          typesOfFirstToParenthesise: const {Add, Subtract, Multiply, Divide},
          typesOfSecondToParenthesise: const {Add, Subtract, Multiply, Divide},
        );
}
