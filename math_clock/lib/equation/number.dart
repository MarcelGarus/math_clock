import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'math_node_widget.dart';
import 'tight_text.dart';

class NumberWidget extends MathNodeWidget {
  const NumberWidget(Number node) : super(node);

  @override
  Widget build(BuildContext context) {
    return TightText(
      '${(node as Number).number}',
    );
  }
}
