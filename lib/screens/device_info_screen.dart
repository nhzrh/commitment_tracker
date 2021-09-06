import 'package:commitment_tracker/common/api/user_device_info.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({Key key}) : super(key: key);

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  DeviceInfoModel _deviceData = DeviceInfoModel();
  String _ipv4, _ipv6;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = await UserDeviceInfo.getDeviceData();
    var ipv4 = await Ipify.ipv4();
    var ipv6 = await Ipify.ipv64();
    if (!mounted) {
      return;
    }
    setState(() {
      _deviceData = deviceData;
      _ipv4 = ipv4;
      _ipv6 = ipv6;
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
                  buildInfo('IPV4', _ipv4 ?? ''),
                  buildInfo('IPV4', _ipv6 ?? ''),
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
