part of 'equation.dart';

class _SubtractWidget extends _MathNodeWidget {
  const _SubtractWidget(Subtract node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _MathNodeWidget(first),
        Text(' - '),
        _bracketIfTypeOf(second, [Add, Subtract]),
      ],
    );
  }
}
