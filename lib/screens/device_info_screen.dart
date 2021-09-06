import 'package:commitment_tracker/common/utils/user_device_info.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({Key key}) : super(key: key);

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  DeviceInfoModel _deviceData = DeviceInfoModel();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = DeviceInfoModel();
    deviceData = await UserDeviceInfo.getDeviceData();
    if (!mounted) {
      return;
    }
    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: _deviceData != null
            ? Column(
                children: [
                  buildInfo('Phone', _deviceData.deviceModelFullName ?? ''),
                  SizedBox(height: 16),
                  _deviceData.allInfo?.keys == null
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: _deviceData.allInfo.keys.map((key) {
                            final value = _deviceData.allInfo[key];

                            return buildInfo(key, value);
                          }).toList(),
                        )
                ],
              )
            : null,
      ),
    );
  }

  Widget buildInfo(String title, dynamic value) => Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$value',
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      );
}
