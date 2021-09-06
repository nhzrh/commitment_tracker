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
        child: _deviceData != null
            ? Column(
                children: [
                  Text(_deviceData.deviceModelFullName ?? ''),
                  Column(
                    children: _deviceData.allInfo?.keys != null
                        ? _deviceData.allInfo.keys.map(
                            (String property) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      property,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        '${_deviceData.allInfo[property]}',
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList()
                        : [],
                  )
                ],
              )
            : null,
      ),
    );
  }
}
