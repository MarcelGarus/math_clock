part of 'equation.dart';

class _ModuloWidget extends _MathNodeWidget {
  const _ModuloWidget(Modulo node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _bracketIfTypeOf(first, [Add, Subtract, Multiply, Divide]),
        Text(' % '),
        _bracketIfTypeOf(second, [Add, Subtract, Multiply, Divide]),
      ],
    );
  }
}
