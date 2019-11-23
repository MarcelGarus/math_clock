part of 'equation.dart';

class _SquaredWidget extends _MathNodeWidget {
  const _SquaredWidget(Squared node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bracketIfTypeOf(
          first,
          [Add, Subtract, Multiply, Divide, Modulo, Cubed],
        ),
        SizedBox(width: 4),
        Text('²'),
      ],
    );
  }
}
