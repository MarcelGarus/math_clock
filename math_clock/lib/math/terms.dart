/// All the [Term]s.

import 'utils.dart';

/// A math term.
///
/// Is actually the root node of the math term and possibly has [children].
/// Can be [compute]d.
abstract class Term {
  const Term(this.children);

  final List<Term> children;
  Term get first => children.first;
  Term get second => children[1];

  int compute();
}

class Number extends Term {
  const Number(this.number) : super(const []);

  final int number;

  int compute() => number;

  String toString() => '$number';
}

class Add extends Term {
  Add(Term operand, Term otherOperand) : super([operand, otherOperand]);

  int compute() => first.compute() + second.compute();

  String toString() => '($first + $second)';
}

class Subtract extends Term {
  Subtract(Term operand, Term otherOperand) : super([operand, otherOperand]);

  int compute() => first.compute() - second.compute();

  String toString() => '($first - $second)';
}

class Multiply extends Term {
  Multiply(Term operand, Term otherOperand) : super([operand, otherOperand]);

  int compute() => first.compute() * second.compute();

  String toString() => '($first * $second)';
}

class Divide extends Term {
  Divide(Term dividend, Term divisor) : super([dividend, divisor]);

  int compute() => first.compute() ~/ second.compute();

  String toString() => '($first / $second)';
}

class Modulo extends Term {
  Modulo(Term operand, Term base) : super([operand, base]);

  int compute() => first.compute() % second.compute();

  String toString() => '($first % $second)';
}

class Squared extends Term {
  Squared(Term operand) : super([operand]);

  int compute() => squared(first.compute());

  String toString() => '($first)²';
}

class Cubed extends Term {
  Cubed(Term operand) : super([operand]);

  int compute() => cubed(first.compute());

  String toString() => '($first)³';
}

class Root extends Term {
  Root(Term operand) : super([operand]);

  int compute() => sqrt(first.compute());

  String toString() => 'sqrt($first)';
}

class Factorial extends Term {
  Factorial(Term operand) : super([operand]);

  int compute() => factorial(first.compute());

  String toString() => '($first)!';
}
