abstract class MathNode {
  const MathNode(this.children);

  final List<MathNode> children;
}

mixin SingleChildNode on MathNode {
  MathNode get child => children.single;
}

class Number extends MathNode {
  const Number(this.number) : super(const []);
  final int number;
  String toString() => '$number';
}

class Add extends MathNode {
  Add(MathNode operand, MathNode otherOperand) : super([operand, otherOperand]);
  String toString() => '(${children.first} + ${children.last})';
}

class Subtract extends MathNode {
  Subtract(MathNode operand, MathNode otherOperand)
      : super([operand, otherOperand]);
  String toString() => '(${children.first} - ${children.last})';
}

class Multiply extends MathNode {
  Multiply(MathNode operand, MathNode otherOperand)
      : super([operand, otherOperand]);
  String toString() => '(${children.first} * ${children.last})';
}

class Divide extends MathNode {
  Divide(MathNode dividend, MathNode divisor) : super([dividend, divisor]);
  String toString() => '(${children.first} / ${children.last})';
}

class Modulo extends MathNode {
  Modulo(MathNode operand, MathNode base) : super([operand, base]);
  String toString() => '(${children.first} % ${children.last})';
}

class Squared extends MathNode with SingleChildNode {
  Squared(MathNode operand) : super([operand]);
  String toString() => '($child)^2';
}

class Cubed extends MathNode with SingleChildNode {
  Cubed(MathNode operand) : super([operand]);
  String toString() => '($child)^3';
}

class Root extends MathNode with SingleChildNode {
  Root(MathNode operand) : super([operand]);
  String toString() => 'sqrt($child)';
}

class Factorial extends MathNode with SingleChildNode {
  Factorial(MathNode operand) : super([operand]);
  String toString() => '($child)!';
}
