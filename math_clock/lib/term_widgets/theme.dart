import 'package:flutter/widgets.dart';

/// Propagates [TermThemeData] in the subtree.
class TermTheme extends StatelessWidget {
  TermTheme({Key key, @required this.data, @required this.child})
      : assert(data != null),
        assert(child != null),
        super(key: key);

  final TermThemeData data;
  final Widget child;

  static TermThemeData of(BuildContext context) =>
      (context.ancestorWidgetOfExactType(TermTheme) as TermTheme).data;

  @override
  Widget build(_) => child;
}

@immutable
class TermThemeData {
  TermThemeData({@required this.color}) : assert(color != null);

  final Color color;
}
