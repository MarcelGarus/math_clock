import 'dart:math' show Random;

import 'package:flutter/foundation.dart';

import 'terms.dart';
import 'utils.dart';

/// The inclusive maximum value of a math term.
/// If you would call [compute] on every instance of [Term], all of these
/// computations would yield results in the inclusive range from 0 to
/// [_maximumValue].
const _maximumValue = 100;

/// The maximum divisor of a [Modulo] operation.
const _maximumModuloDivisor = 10;

/// Creates a complicated [Term] that evalutes to the given [number].
// Creates a node from the number, then makes that node more complicated a few
// times. While doing so, uses every operator at most once.
Term generateMathTerm(int number) {
  assert(number != null);

  // All the possible types that still can be used. The set is mutable and the
  // [makeMoreComplicated] method removes types, so over time there are less
  // and less types to choose from.
  var possibleTypes = <Type>{
    Add, // a + b
    Subtract, // a - b
    Multiply, // a * b
    Divide, // a / b
    Modulo, // a % b
    Squared, // a^2
    Cubed, // a^3
    Root, // sqrt(a)
    Factorial, // a!
  };

  // Create a node from the number and make it more complicated a few times.
  var complexity = 2 + Random().nextInt(2);
  Term node = Number(number);

  for (var step = 0; step < complexity; step++) {
    node = _makeMoreComplicated(node, possibleTypes);
  }

  return node;
}

/// Returns a new node that produces the same result, but is (most of the time)
/// more complicated.
/// Also mutates the [possibleTypes].
Term _makeMoreComplicated(Term node, Set<Type> possibleTypes) {
  if (node is! Number) {
    // We only complicate numbers, which are the leaves of the tree.
    // Other nodes simply forward the call to a random child.
    assert(node.children.isNotEmpty);
    var index = Random().nextInt(node.children.length);
    node.children[index] = _makeMoreComplicated(
      node.children[index],
      possibleTypes,
    );
    return node; // Now a child is (possibly) more complicated.
  }

  assert(node is Number);

  // Get a replacement for the number.
  final replacement = _makeNumberMoreComplicated(
    number: (node as Number).number,
    isPossible: possibleTypes.contains,
  );
  final type = replacement.runtimeType;

  // Using the replacement, we disallow some types of operations to be used
  // in further complications.
  possibleTypes.removeAll({
    // Every operation should only be used at most once in order to get great,
    // diverse terms. So, the replacement's type should not be used a second
    // time.
    type,

    // If we allow square and root operations to be used in the same equation,
    // we often end up with something like sqrt(x^2) or sqrt(x)^2.
    // So, we simply don't allow both operations in the same equation.
    if (type == Root)
      Squared,
    if (type == Squared)
      Root,

    // If we allow multiply and divide operations to be used in the same
    // equation, we often end up with something like (x/n)*n or x*n/n.
    // So, we simply don't allow both operations in the same equation.
    if (type == Multiply)
      Divide,
    if (type == Divide)
      Multiply,
  });

  return replacement;
}

Term _makeNumberMoreComplicated({
  @required int number,
  @required bool Function(Type type) isPossible,
}) {
  // It would not be enough to just create a list of all possible replacements
  // and then choose a random one, because for example, there are so many more
  // addition operations possible than factorial ones.
  // That's why we have multiple replacement categories, each containing only
  // operations which are about equally rare. Categories with more rare
  // replacements are first in the following list.
  final replacementCategories = [
    /// Amazingly rare replacements: [Factorial]
    [
      if (isPossible(Factorial))
        for (var i = 0; factorial(i) <= _maximumValue; i++)
          if (number == factorial(i)) Factorial(Number(i)),
    ],

    /// Rare replacements: [Squared], [Cubed], [Root]
    [
      if (isPossible(Squared))
        for (var i = 0; squared(i) <= number; i++)
          if (i * i == number) Squared(Number(i)),
      if (isPossible(Cubed))
        for (var i = 0; cubed(i) <= number; i++)
          if (cubed(i) == number) Cubed(Number(i)),
      if (isPossible(Root))
        if (squared(number) <= _maximumValue) Root(Number(squared(number))),
    ],

    /// Common replacements: [Multiply], [Divide], [Modulo]
    [
      if (isPossible(Divide) && number > 0)
        for (var i = 2; i * number <= _maximumValue; i++)
          Divide(Number(i * number), Number(i)),
      if (isPossible(Multiply))
        for (var i = 2; i < number; i++)
          if (number % i == 0 && i != number ~/ i)
            Multiply(Number(i), Number(number ~/ i)),
      if (isPossible(Modulo))
        for (var base = number + 1; base <= _maximumModuloDivisor; base++)
          for (var i = number; i <= _maximumValue; i += base)
            Modulo(Number(i), Number(base)),
    ],

    /// Very common replacements: [Add], [Subtract]
    [
      if (isPossible(Add))
        for (var i = 1; i < number; i++) Add(Number(i), Number(number - i)),
      if (isPossible(Subtract))
        for (var i = number + 1; i <= 100; i++)
          Subtract(Number(i), Number(i - number)),
    ],
  ]..removeWhere((category) => category.isEmpty);

  if (replacementCategories.isEmpty) {
    // Not a single replacement can be applied to this number.
    // In that case, just return the same unchanged number.
    return Number(number);
  }

  // With a 20% chance, we skip a better category for the next worst.
  while (replacementCategories.length > 1 && Random().nextDouble() < 0.2) {
    replacementCategories.removeAt(0);
  }
  final chosenCategory = replacementCategories.first;

  // Within the chosen category, we choose randomly.
  return chooseRandomOf(chosenCategory);
}
