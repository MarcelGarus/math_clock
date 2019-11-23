import 'dart:math' as math;

T chooseRandomOf<T>(List<T> items) =>
    items[math.Random().nextInt(items.length)];

int squared(int number) => math.pow(number, 2);
int cubed(int number) => math.pow(number, 3);
int sqrt(int number) => math.sqrt(number).round();
int factorial(int number) => number < 2 ? 1 : number * factorial(number - 1);
