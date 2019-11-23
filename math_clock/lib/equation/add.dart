part of 'equation.dart';

class AddWidget extends _MathNodeWidget {
  const AddWidget(Add node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _MathNodeWidget(first),
        Text(' + '),
        _MathNodeWidget(second),
      ],
    );
  }
}
