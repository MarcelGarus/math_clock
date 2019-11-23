part of 'equation.dart';

class _MultiplyWidget extends _MathNodeWidget {
  const _MultiplyWidget(Multiply node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _bracketIfTypeOf(first, [Add, Subtract]),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: EquationTheme.of(context).color,
          ),
          margin: EdgeInsets.symmetric(horizontal: 4),
        ),
        _bracketIfTypeOf(second, [Add, Subtract]),
      ],
    );
  }
}
