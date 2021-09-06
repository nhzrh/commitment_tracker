import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionCheckerScreen extends StatelessWidget {
  const PermissionCheckerScreen({Key key}) : super(key: key);

  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Location Permission: ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _checkPermission,
            child: Text('Check Location Permission'),
          ),
        ],
      ),
    );
  }
}
