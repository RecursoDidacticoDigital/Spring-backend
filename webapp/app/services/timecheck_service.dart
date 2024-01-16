import 'package:flutter/material.dart';

import 'dart:async';

class TimeCheckService {
  Timer? _timer;
  Function? onTimeBlockChange;

  void startTimer() {
    _timer = Timer.periodic(Duration(minutes: 30), (timer) {
      if (_isNewTimeblock()) {
        onTimeBlockChange?.call();
      }
    });
  }

  bool _isNewTimeblock() {
    // Logic to check if a new timeblock has started
    // ...
    return true; // return true if new timeblock has started
  }

  void dispose() {
    _timer?.cancel();
  }
}

