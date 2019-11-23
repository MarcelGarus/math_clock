import 'dart:math';

import 'nodes.dart';

T chooseRandomOf<T>(List<T> items) => items[Random().nextInt(items.length)];

int squared(int number) => pow(number, 2);
int cubed(int number) => pow(number, 3);

// Creates a node from the number, then makes that node more complicated a few
// times. While doing this, use every operand at least once.
MathNode createMathTree(int number) {
  MathNode node = Number(number);

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

  // Make the node more complicated a few times.
  var complexity = 2 + Random().nextInt(2);
  for (var step = 0; step < complexity; step++) {
    node = _makeMoreComplicated(node, possibleTypes);
  }
  return node;
}

/// Returns a new node that produces the same result, but is (most of the time)
/// more complicated.
/// Also mutates the [possibleTypes].
MathNode _makeMoreComplicated(MathNode node, Set<Type> possibleTypes) {
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

MathNode _makeNumberMoreComplicated({
  int number,
  bool Function(Type type) isPossible,
}) {
  // Create a list of replacements wrapped inside replacement categories
  // according to their subjective coolness.
  final replacementCategories = [
    // Amazingly cool replacements.
    // Faculty operations are really rarely applicable, so if they can be used,
    // they should almost always be used.
    [
      if (isPossible(Factorial)) ...[
        if (number == 6) Factorial(Number(3)),
        if (number == 24) Factorial(Number(4)),
      ],
    ],
    // Cool replacements.
    // Squared, cubed and root operations are still quite rare, so they should
    // also be used most of the time when they can be applied.
    [
      if (isPossible(Squared))
        for (var i = 2; squared(i) <= number; i++)
          if (i * i == number) Squared(Number(i)),
      if (isPossible(Cubed))
        for (var i = 0; cubed(i) <= number; i++)
          if (cubed(i) == number) Cubed(Number(i)),
      if (isPossible(Root))
        if (squared(number) <= 100) Root(Number(squared(number))),
    ],
    // Okay-ish replacements.
    // Multiplying and dividing numbers is also okay, but more common.
    [
      if (isPossible(Divide) && number > 0)
        for (var i = 2; i * number <= 100; i++)
          Divide(Number(i * number), Number(i)),
      if (isPossible(Multiply))
        for (var i = 2; i < number; i++)
          if (number % i == 0 && i != number ~/ i)
            Multiply(Number(i), Number(number ~/ i)),
      if (isPossible(Modulo) && number < 10)
        for (var base = 2; base < number; base++)
          for (var i = number; i < 100; i += base)
            Modulo(Number(i), Number(base)),
    ],
    // Meh replacements.
    // Addition and subtraction work all the time, so these are at the bottom
    // of the coolness hierarchy.
    [
      if (isPossible(Add))
        for (var i = 1; i < number; i++) Add(Number(i), Number(number - i)),
      if (isPossible(Subtract))
        for (var i = number + 1; i <= 100; i++)
          Subtract(Number(i), Number(i - number)),
    ],
  ]..removeWhere((category) => category.isEmpty);

  if (replacementCategories.isEmpty) {
    // Not a single replacement can be applied to this number (that probably
    // means we used up the addition and subtraction and the others don't
    // apply).
    // In that case, just return the same unchanged number.
    return Number(number);
  }

  // With a 20% chance, we skip a better category for the next worst.
  while (replacementCategories.length > 1 && Random().nextDouble() < 0.2) {
    replacementCategories.removeAt(0);
  }
  final chosenCategory = replacementCategories.first;

  // Within a category, we choose randomly.
  return chooseRandomOf(chosenCategory);
}
