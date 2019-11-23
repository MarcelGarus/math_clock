part of 'equation.dart';

class _FactorialWidget extends _MathNodeWidget {
  const _FactorialWidget(Factorial node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _bracketIfTypeOf(
          first,
          [Add, Subtract, Multiply, Divide, Squared, Cubed],
        ),
        Text('!'),
      ],
    );
  }
}
