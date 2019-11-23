part of 'equation.dart';

class _DivideWidget extends _MathNodeWidget {
  const _DivideWidget(Divide node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _bracketIfTypeOf(first, [Add, Subtract]),
        Text('/'),
        _bracketIfTypeOf(second, [Add, Subtract]),
      ],
    );
  }
}
