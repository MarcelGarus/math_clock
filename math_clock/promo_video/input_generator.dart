
// Promo video stuff. Because the promo video is only 30 seconds, we need
// to hurry and display terms more rapidly. Also, we hardcoded beautiful
// terms that don't occlude the camera during transitions.
Future.microtask(() async {
  // Video synchronization.
  setState(() => _ready = false);
  await Future.delayed(Duration(seconds: 1));
  setState(() => _ready = true);

  // Introduction.
  // 16:37
  setState(() {
    _hourTerm =
        Root(Subtract(Factorial(Number(3)), Modulo(Number(14), Number(3))));
    _minuteTerm = Subtract(Multiply(Number(17), Number(3)), Number(14));
  });
  await Future.delayed(Duration(seconds: 8));

  // Currently zooming in on the clock.
  // 16:38
  setState(() => _minuteTerm = Subtract(Number(62), Factorial(Number(4))));
  await Future.delayed(Duration(seconds: 2));

  // Zooming out again while changing through themes.
  // 16:39
  await Future.delayed(Duration(seconds: 3));
  setState(() => _minuteTerm = Multiply(Root(Number(9)), Number(13)));
  await Future.delayed(Duration(seconds: 5));
  // 16:40
  setState(() => _minuteTerm =
      Multiply(Modulo(Number(58), Number(10)), Root(Number(25))));

  await Future.delayed(Duration(seconds: 15));
  setState(() => _ready = false);
  await Future.delayed(Duration(seconds: 1));
  setState(() => _ready = true);
});