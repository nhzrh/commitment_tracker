import 'package:commitment_tracker/base/base_stateful.dart';
import 'package:commitment_tracker/common/utils/user_network_info.dart';
import 'package:commitment_tracker/models/network_info_model.dart';
import 'package:flutter/material.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({Key key}) : super(key: key);

  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends BaseStateful<NetworkScreen> {
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    initNetworkInfo();
  }

  Future<void> initNetworkInfo() async {
    NetworkInfoModel networkInfoModel;
    networkInfoModel = await UserNetworkInfo.getAllNetworkInfo();
    if (!mounted) {
      return;
    }
    setState(() {
      _connectionStatus = 'Wifi Name: ${networkInfoModel.wifiName}\n'
          'Wifi BSSID: ${networkInfoModel.wifiBSSID}\n'
          'Wifi IPv4: ${networkInfoModel.wifiIPv4}\n'
          'Wifi IPv6: ${networkInfoModel.wifiIPv6}\n'
          'Wifi Broadcast: ${networkInfoModel.wifiBroadcast}\n'
          'Wifi Gateway: ${networkInfoModel.wifiGatewayIP}\n'
          'Wifi Submask: ${networkInfoModel.wifiSubmask}\n';
    });
  }

  @override
  List<Widget> getAction() => null;

  @override
  String getAppTitle() => "Network Demo";

  @override
  Widget getBottomNavigation() => null;

  @override
  Widget getChildView() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(_connectionStatus),
        ),
      );

  @override
  Widget getDrawer() => null;

  @override
  Widget getFloatingActionButton() => null;
}
