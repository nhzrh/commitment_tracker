import 'package:flutter/material.dart';

class CustomDialog {
  static Future generalDialog({
    BuildContext mContext,
    String title,
    String content,
    String cancelText,
    String proceedText,
    Function onProceed,
    bool isCancelButton: true,
    bool barrierDismissible: true,
  }) {
    return showGeneralDialog(
      context: mContext,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(mContext).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 180),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
              title: Text(
                title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              content: Text(content ?? ''),
              actions: <Widget>[
                Visibility(
                  visible: isCancelButton,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      (cancelText ?? 'Cancel').toUpperCase(),
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  ),
                ),
                Visibility(
                  visible: onProceed != null,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      onProceed();
                    },
                    child: Text(
                      (proceedText ?? 'Leave').toUpperCase(),
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      pageBuilder: (context, anim1, anim2) => null,
    );
  }
}
