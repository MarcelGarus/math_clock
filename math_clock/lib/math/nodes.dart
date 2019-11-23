/// All the [MathNode]s.

import 'utils.dart';

/// A node in a math term. Possibly has [children]. Can be [compute]d.
abstract class MathNode {
  const MathNode(this.children);

  final List<MathNode> children;
  MathNode get first => children.first;
  MathNode get second => children[1];

  int compute();
}

class Number extends MathNode {
  const Number(this.number) : super(const []);

  final int number;

  int compute() => number;

  String toString() => '$number';
}

class Add extends MathNode {
  Add(MathNode operand, MathNode otherOperand) : super([operand, otherOperand]);

  int compute() => first.compute() + second.compute();

  String toString() => '($first + $second)';
}

class Subtract extends MathNode {
  Subtract(MathNode operand, MathNode otherOperand)
      : super([operand, otherOperand]);

  int compute() => first.compute() - second.compute();

  String toString() => '($first - $second)';
}

class Multiply extends MathNode {
  Multiply(MathNode operand, MathNode otherOperand)
      : super([operand, otherOperand]);

  int compute() => first.compute() * second.compute();

  String toString() => '($first * $second)';
}

class Divide extends MathNode {
  Divide(MathNode dividend, MathNode divisor) : super([dividend, divisor]);

  int compute() => first.compute() ~/ second.compute();

  String toString() => '($first / $second)';
}

class Modulo extends MathNode {
  Modulo(MathNode operand, MathNode base) : super([operand, base]);

  int compute() => first.compute() % second.compute();

  String toString() => '($first % $second)';
}

class Squared extends MathNode {
  Squared(MathNode operand) : super([operand]);

  int compute() => squared(first.compute());

  String toString() => '($first)²';
}

class Cubed extends MathNode {
  Cubed(MathNode operand) : super([operand]);

  int compute() => cubed(first.compute());

  String toString() => '($first)³';
}

class Root extends MathNode {
  Root(MathNode operand) : super([operand]);

  int compute() => sqrt(first.compute());

  String toString() => 'sqrt($first)';
}

class Factorial extends MathNode {
  Factorial(MathNode operand) : super([operand]);

  int compute() => factorial(first.compute());

  String toString() => '($first)!';
}
