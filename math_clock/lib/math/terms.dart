/// All the [Term]s.

import 'utils.dart';

/// A math term.
///
/// Every mathematical expression that can be seen on the clock is a [Term] –
/// that's everything from single numbers up to complex mathematical
/// expressions.
/// Complex terms are actually composed of simpler terms. All the terms have a
/// single purpose only and together, they form a tree of terms. Here are
/// different kinds of terms, that can have none, one or two children:
/// - [Number] is the only type of term that has no children and thereby is a
///   leaf in the tree.
/// - There are several terms with one child only. For example, there's the
///   [Squared] and [Cubed] terms, or the [Factorial] term.
/// - There are also terms with two children. Examples are [Add] terms and
///   [Subtract] terms.
///
/// Terms can also be [compute]d. That's only used in debug mode, so generators
/// can be sure that the created term yields the right result.
abstract class Term {
  const Term(this.children) : assert(children != null);

  final List<Term> children;

  // Convenience getter for subclasses with one child.
  Term get operand => children.single;

  // Convenience getters for subclasses with two children.
  Term get first => children.first;
  Term get second => children[1];

  /// Computes the result of this term.
  int compute();
}

/// A single [number].
class Number extends Term {
  const Number(this.number)
      : assert(number != null),
        super(const []);

  final int number;

  int compute() => number;

  String toString() => '$number';
}

/// A [Term] that adds [first] to [second].
class Add extends Term {
  Add(Term first, Term second) : super([first, second]);

  int compute() => first.compute() + second.compute();

  String toString() => '($first + $second)';
}

/// A [Term] that subtracts [second] from [first].
class Subtract extends Term {
  Subtract(Term first, Term second) : super([first, second]);

  int compute() => first.compute() - second.compute();

  String toString() => '($first - $second)';
}

/// A [Term] that multiplies [first] with [second].
class Multiply extends Term {
  Multiply(Term first, Term second) : super([first, second]);

  int compute() => first.compute() * second.compute();

  String toString() => '($first * $second)';
}

/// A [Term] that divides [frist] by [second].
class Divide extends Term {
  Divide(Term dividend, Term divisor) : super([dividend, divisor]);

  int compute() => first.compute() ~/ second.compute();

  String toString() => '($first / $second)';
}

/// A [Term] that calculates the remainder when dividing [first] by [second].
class Modulo extends Term {
  Modulo(Term first, Term second) : super([first, second]);

  int compute() => first.compute() % second.compute();

  String toString() => '($first % $second)';
}

/// A [Term] that squares the given [operand].
class Squared extends Term {
  Squared(Term operand) : super([operand]);

  int compute() => squared(operand.compute());

  String toString() => '($operand)²';
}

/// A [Term] that cubes the given [operand].
class Cubed extends Term {
  Cubed(Term operand) : super([operand]);

  int compute() => cubed(operand.compute());

  String toString() => '($operand)³';
}

/// A [Term] that calculates the square root of the given [operand].
class Root extends Term {
  Root(Term operand) : super([operand]);

  int compute() => sqrt(operand.compute());

  String toString() => 'sqrt($operand)';
}

/// A [Term] that calculates the [Factorial] of the given [operand].
class Factorial extends Term {
  Factorial(Term operand) : super([operand]);

  int compute() => factorial(operand.compute());

  String toString() => '($operand)!';
}
