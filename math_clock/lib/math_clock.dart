// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:math_clock/math/math.dart';

import 'slanted_layout/slanted_layout.dart';

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  Timer _timer;
  int _lastHour;
  int _lastMinute;
  MathNode _hourEquation;
  MathNode _minuteEquation;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      // Update once per minute.
      final dateTime = DateTime.now();
      final hour = dateTime.hour % (widget.model.is24HourFormat ? 24 : 12);
      final minute = dateTime.minute;

      if (hour != _lastHour) {
        _lastHour = hour;
        _hourEquation = createMathTree(hour);
        print(_hourEquation);
      }
      if (minute != _lastMinute) {
        _lastMinute = minute;
        _minuteEquation = createMathTree(minute);
        print(_minuteEquation);
      }

      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: dateTime.second) -
            Duration(milliseconds: dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 500,
        height: 300,
        alignment: Alignment.center,
        child: SlantedLayout(
          hour: _hourEquation,
          minute: _minuteEquation,
          primaryColor: Color.lerp(Colors.deepPurple, Colors.black, 0.4),
          secondaryColor: Colors.yellowAccent,
        ),
      ),
    );
  }
}
