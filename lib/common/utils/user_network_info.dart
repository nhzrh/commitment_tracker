import 'dart:io';

import 'package:commitment_tracker/models/network_info_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

class UserNetworkInfo {
  static final NetworkInfo _networkInfo = NetworkInfo();
  static NetworkInfoModel _model = NetworkInfoModel();

  static Future<NetworkInfoModel> getAllNetworkInfo() async {
    _model.wifiName = await getWifiName();
    _model.wifiBSSID = await getWifiBSSID();
    _model.wifiIPv4 = await getWifiIP();
    _model.wifiIPv6 = await getWifiIPv6();
    _model.wifiGatewayIP = await getWifiGatewayIP();
    _model.wifiBroadcast = await getWifiBroadcast();
    _model.wifiSubmask = await getWifiSubmask();
    return _model;
  }

  static Future<String> getWifiName() async {
    String result;
    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          result = await _networkInfo.getWifiName();
        } else {
          result = await _networkInfo.getWifiName();
        }
      } else {
        result = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi Name';
    }
    return result;
  }

  static Future<String> getWifiBSSID() async {
    String result;
    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          result = await _networkInfo.getWifiBSSID();
        } else {
          result = await _networkInfo.getWifiBSSID();
        }
      } else {
        result = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi BSSID';
    }
    return result;
  }

  static Future<String> getWifiIP() async {
    String result;
    try {
      result = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi IPv4';
    }
    return result;
  }

  static Future<String> getWifiIPv6() async {
    String result;
    try {
      result = await _networkInfo.getWifiIPv6();
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi IPv6';
    }
    return result;
  }

  static Future<String> getWifiGatewayIP() async {
    String result;
    try {
      result = await _networkInfo.getWifiGatewayIP();
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi gateway address';
    }
    return result;
  }

  static Future<String> getWifiBroadcast() async {
    String result;
    try {
      result = await _networkInfo.getWifiBroadcast();
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi broadcast';
    }
    return result;
  }

  static Future<String> getWifiSubmask() async {
    String result;
    try {
      result = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      print(e.toString());
      result = 'Failed to get Wifi submask address';
    }
    return result;
  }
}
