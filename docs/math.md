Internally, terms are represented as a trees.

As of now, these are all the supported operations:

- Add
- Subtract
- Multiply
- Divide
- Modulo
- Squared
- Cubed
- Root
- Factorial

For example, this is how the term `sqrt(4 * 3 + 4)` is represented:

[...]

## Generating terms

The task is to generate a term which evaluates to a given number.

We do that by creating a term containing a single number and then making it more complicated using these steps:

- Find a leaf by randomly walking down the tree until we reach a number.
- Choosing a random replacement.

