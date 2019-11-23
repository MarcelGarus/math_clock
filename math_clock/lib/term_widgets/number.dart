import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'term_widget.dart';
import 'tight_text.dart';

/// Renders a single [Number].
class NumberWidget extends TermWidget {
  const NumberWidget(Number number) : super(number);

  @override
  Widget build(BuildContext context) {
    return TightText('${(term as Number).number}');
  }
}
