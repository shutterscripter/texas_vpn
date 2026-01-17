import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountDownTimer extends StatefulWidget {
  final bool StartTimer;
  const CountDownTimer({super.key, required this.StartTimer});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration = Duration();
  Timer? _timer;

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _duration = Duration();
  }

  @override
  Widget build(BuildContext context) {
    if (_timer == null || !widget.StartTimer) {
      widget.StartTimer ? _startTimer() : _stopTimer();
    }

    twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    final hours = twoDigits(_duration.inHours.remainder(24));
    return Center(
      child: Text(
        '${hours}:${minutes}:${seconds}',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
