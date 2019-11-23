part of 'equation.dart';

class _CubedWidget extends _MathNodeWidget {
  const _CubedWidget(Cubed node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _bracketIfTypeOf(
          first,
          [Add, Subtract, Multiply, Divide, Modulo, Squared],
        ),
        SizedBox(width: 4),
        Text('³'),
      ],
    );
  }
}
