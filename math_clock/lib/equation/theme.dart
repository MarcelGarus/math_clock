import 'package:flutter/widgets.dart';

class EquationTheme extends StatelessWidget {
  EquationTheme({@required this.data, @required this.child})
      : assert(data != null),
        assert(child != null);

  final EquationThemeData data;
  final Widget child;

  static EquationThemeData of(BuildContext context) =>
      (context.ancestorWidgetOfExactType(EquationTheme) as EquationTheme).data;

  @override
  Widget build(BuildContext context) => child;
}

@immutable
class EquationThemeData {
  EquationThemeData({@required this.color}) : assert(color != null);

  final Color color;
}
