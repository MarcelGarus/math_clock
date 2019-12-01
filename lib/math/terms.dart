import 'dart:math' show max;

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

  /// The depth of the term.
  int get depth => children.map((child) => child.depth).reduce(max) + 1;

  /// A semantic description of this term.
  String toSemanticString() => _toSemanticString(0);
  String _toSemanticString(int depthFromTop) {
    List<String> childrenSemantics = children
        .map((child) => child._toSemanticString(depthFromTop + 1))
        .toList();
    return (depthFromTop == 0)
        ? _toSemanticSentence(childrenSemantics)
        : _toShortSemanticString(childrenSemantics);
  }

  String _toSemanticSentence(List<String> children);
  String _toShortSemanticString(List<String> children);
}

/// A single [number].
class Number extends Term {
  const Number(this.number)
      : assert(number != null),
        super(const []);

  final int number;

  int compute() => number;

  int get depth => 0;

  String toString() => '$number';
  String _toSemanticSentence(_) => '$number';
  String _toShortSemanticString(_) => '$number';
}

/// A [Term] that adds [first] to [second].
class Add extends Term {
  Add(Term first, Term second) : super([first, second]);

  int compute() => first.compute() + second.compute();

  String toString() => '($first + $second)';
  String _toSemanticSentence(children) =>
      '${first.depth > 0 ? 'Calculate' : 'Take'} ${children.first} and add '
      '${children[1]} to that.';
  String _toShortSemanticString(children) =>
      '${children.first} plus ${children[1]}';
}

/// A [Term] that subtracts [second] from [first].
class Subtract extends Term {
  Subtract(Term first, Term second) : super([first, second]);

  int compute() => first.compute() - second.compute();

  String toString() => '($first - $second)';
  String _toSemanticSentence(children) =>
      '${first.depth > 0 ? 'Calculate' : 'Take'} ${children.first} and '
      'subtract ${children[1]} from that.';
  String _toShortSemanticString(children) =>
      '${children.first} minus ${children[1]}';
}

/// A [Term] that multiplies [first] with [second].
class Multiply extends Term {
  Multiply(Term first, Term second) : super([first, second]);

  int compute() => first.compute() * second.compute();

  String toString() => '($first * $second)';
  String _toSemanticSentence(children) =>
      '${first.depth > 0 ? 'Calculate' : 'Take'} ${children.first} and '
      'multiply that by ${children[1]}.';
  String _toShortSemanticString(children) =>
      '${children.first} times ${children[1]}';
}

/// A [Term] that divides [frist] by [second].
class Divide extends Term {
  Divide(Term dividend, Term divisor) : super([dividend, divisor]);

  int compute() => first.compute() ~/ second.compute();

  String toString() => '($first / $second)';
  String _toSemanticSentence(children) =>
      '${first.depth > 0 ? 'Calculate' : 'Take'} ${children.first} and divide '
      'that by ${children[1]}.';
  String _toShortSemanticString(children) =>
      '${children.first} divided by ${children[1]}';
}

/// A [Term] that calculates the remainder when dividing [first] by [second].
class Modulo extends Term {
  Modulo(Term first, Term second) : super([first, second]);

  int compute() => first.compute() % second.compute();

  String toString() => '($first % $second)';
  String _toSemanticSentence(children) =>
      '${first.depth > 0 ? 'Calculate' : 'Take'} ${children.first} and take '
      'that modulo ${children[1]}.';
  String _toShortSemanticString(children) =>
      '${children.first} modulo ${children[1]}';
}

/// A [Term] that squares the given [operand].
class Squared extends Term {
  Squared(Term operand) : super([operand]);

  int compute() => squared(operand.compute());

  String toString() => '($operand)²';
  String _toSemanticSentence(children) => 'Calculate the square of '
      '${children.single}.';
  String _toShortSemanticString(children) => 'the square of ${children.single}';
}

/// A [Term] that cubes the given [operand].
class Cubed extends Term {
  Cubed(Term operand) : super([operand]);

  int compute() => cubed(operand.compute());

  String toString() => '($operand)³';
  String _toSemanticSentence(children) => 'Calculate the cube of '
      '${children.single}.';
  String _toShortSemanticString(children) => 'the cube of ${children.single}';
}

/// A [Term] that calculates the square root of the given [operand].
class Root extends Term {
  Root(Term operand) : super([operand]);

  int compute() => sqrt(operand.compute());

  String toString() => 'sqrt($operand)';
  String _toSemanticSentence(children) => 'Calculate the root of '
      '${children.single}.';
  String _toShortSemanticString(children) => 'the root of ${children.single}';
}

/// A [Term] that calculates the [Factorial] of the given [operand].
class Factorial extends Term {
  Factorial(Term operand) : super([operand]);

  int compute() => factorial(operand.compute());

  String toString() => '($operand)!';
  String _toSemanticSentence(children) => 'Calculate the factorial of '
      '${children.single}.';
  String _toShortSemanticString(children) =>
      'the factorial of ${children.single}';
}
