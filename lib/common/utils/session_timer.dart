import 'dart:async';

import 'package:commitment_tracker/common/components/custom_dialog.dart';
import 'package:commitment_tracker/common/utils/route_generator.dart';
import 'package:commitment_tracker/common/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class SessionTimer {
  static StreamSubscription sub;
  static CountdownTimer _sessionTimer;
  static int _sessionPeriod = 299;

  static start(BuildContext context, {int seconds: 299}) {
    _sessionPeriod = seconds;
    if (_sessionTimer == null) {
      print('TEST :::: timer is $_sessionPeriod seconds');
      _sessionTimer = CountdownTimer(Duration(seconds: _sessionPeriod), Duration(seconds: 1));
      sub = _sessionTimer.listen(null);
      sub.onDone(() {
        if (_sessionTimer != null && _sessionTimer.remaining > Duration(seconds: 0)) {
          //Let user continue using the app
          print("Do nothing if time is still remaining");
        } else {
          print('TEST :::: timer is done');
          CustomDialog.generalDialog(
            mContext: context,
            title: "Session Timeout",
            content: 'Opps! your session is up. proceed logout',
            onProceed: () async {
              await UserSecureStorage.deleteAll();
              Navigator.pushReplacementNamed(context, Routes.logout);
            },
            proceedText: 'Ok',
            barrierDismissible: false,
            isCancelButton: false,
          );
        }
      });
    }
    return _sessionTimer;
  }

  static stop() {
    if (_sessionTimer != null) {
      _sessionTimer.cancel();
      _sessionTimer = null;
      sub = null;
    }
    return null;
  }

  static restart(BuildContext context, int seconds) {
    stop();
    start(context, seconds: seconds);
  }

  static forceRestart(BuildContext context) {
    restart(context, _sessionPeriod);
  }

  static bool isRunning() {
    return _sessionTimer != null;
  }
}
