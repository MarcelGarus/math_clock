part of 'equation.dart';

class _NumberWidget extends _MathNodeWidget {
  const _NumberWidget(Number node) : super(node);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Text(
        '${(node as Number).number}',
      ),
    );
  }
}
