## math_clock

An engaging clock face that shows math terms instead of the numbers themselves.\
This project participates in the Flutter Clock challenge.

## How to use

* Clone the [Flutter Clock GitHub repo](https://github.com/flutter/flutter_clock). It contains several folders, including one named `flutter_clock_helper`.
* In the root folder of the flutter clock repo, clone this repo into a folder named `math_clock`.
* Now, you can run this Flutter project just like any other one.

## How it works

### Generating terms

Instead of numbers, this clock displays math terms with the operations `+` (Add), `-` (Subtract), `*` (Multiply), `/` (Divide), `%` (Modulo), `²` (Squared), `³` (Cubed), `√` (Root) and `!` (Factorial).

Math terms are represented by a tree.

To turn the hour and minute numbers into math terms, we construct a tree consisting only of a number node. Then, it's made more complicated multiple times, each time choosing a random number node and complicating it.

For example, here's how a `2` might be turned into a more complicated math term:

```
2 │ 66 % 4 │ 66 % 2² │ (22 * 3) % 2²
  │        │         │ 
2 │   %    │   %     │     %
  │  / \   │  / \    │    / \
  │ 66  4  │ 66  ²   │   *   ²
  │        │     |   │  / \  |
  │        │     2   │ 22  3 2
```

See the `math` folder for more details.

### Rendering terms

There's a `TermWidget` that can render a math term.
It does so by expanding every math node into multiple widgets.
By checking the types of the child nodes, it also inserts parenthesis where necessary.

Here's how the term tree from above is translated into widgets. For legibility, widgets created from the same math node are grouped together:

```
            ┌──────────────────────┐
            │      TermWidget      │
            │    (22 * 3) % 2²     │
            │                      │
            │     ModuloWidget     │
            │    (22 * 3) % 2²     │
            │                      │
            │_BinaryOperationWidget│
            │    (22 * 3) % 2²     │
            │                      │
            │  ParenthesisWidget   │
            │        22 * 3        │
            └──────────────────────┘
                 |             |
┌──────────────────────┐ ┌───────────────────────┐
│      TermWidget      │ │      TermWidget       │
│        22 * 3        │ │           2²          │
│                      │ │                       │
│    MultiplyWidget    │ │    MultiplyWidget     │
│        22 * 3        │ │           2²          │
│                      │ │                       │
│_BinaryOperationWidget│ │_PostfixOperationWidget│
│        22 * 3        │ │           2²          │
└──────────────────────┘ └───────────────────────┘
      |            |                 |
┌────────────┐ ┌────────────┐  ┌────────────┐
│ TermWidget │ │ TermWidget │  │ TermWidget │
│     22     │ │     3      │  │     2      │
│            │ │            │  │            │
│NumberWidget│ │NumberWidget│  │NumberWidget│
│     22     │ │     3      │  │     2      │
│            │ │            │  │            │
│ TightText  │ │ TightText  │  │ TightText  │
│     22     │ │     3      │  │     2      │
└────────────┘ └────────────┘  └────────────┘
```
