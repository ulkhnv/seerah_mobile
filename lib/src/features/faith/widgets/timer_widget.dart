import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class TimerWidget extends StatefulWidget {
  final String time;
  final bool isFajr;

  const TimerWidget(this.time, this.isFajr, {super.key});

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _initializeTimer() {
    final parsedTime = _parseTime(widget.time);
    final currentTime = DateTime.now();
    final targetDateTime = DateTime(
      currentTime.year,
      currentTime.month,
      widget.isFajr ? currentTime.day + 1 : currentTime.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    _secondsRemaining = targetDateTime.difference(currentTime).inSeconds;
  }

  TimeOfDay _parseTime(String time) {
    try {
      final parts = time.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      throw const FormatException("Invalid time format");
    }
  }

  void _updateTimer(Timer timer) {
    if (_secondsRemaining > 0) {
      setState(() {
        _secondsRemaining--;
      });
    } else {
      _timer.cancel();
    }
  }

  String _formatTime(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final remainingSeconds = duration.inSeconds % 60;

    return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(remainingSeconds)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_secondsRemaining),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryGreen,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
