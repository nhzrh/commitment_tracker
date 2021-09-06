import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class DeviceInfoModel {
  String applicationGUID;
  String deviceModelFullName;
  String osVersion;
  Map<String, dynamic> allInfo;
  DeviceInfoModel({this.applicationGUID, this.deviceModelFullName, this.osVersion, this.allInfo});
}

class UserDeviceInfo {
  static DeviceInfoModel deviceData = DeviceInfoModel();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Future<String> getOperatingSystem() async => Platform.operatingSystem;

  static Future<DeviceInfoModel> getDeviceData() async {
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData =
          DeviceInfoModel(allInfo: <String, dynamic>{'Error:': 'Failed to get platform version.'});
    }
    return deviceData;
  }

  static DeviceInfoModel _readAndroidBuildData(AndroidDeviceInfo data) {
    DeviceInfoModel deviceInfoModel = DeviceInfoModel(
      applicationGUID: data.androidId,
      deviceModelFullName: '${data.manufacturer} ${data.model} (Android ${data.version.release})',
      osVersion: data.version.sdkInt.toString(),
      allInfo: <String, dynamic>{
        'version.securityPatch': data.version.securityPatch,
        'version.sdkInt': data.version.sdkInt, //OS version
        'version.release': data.version.release,
        'version.previewSdkInt': data.version.previewSdkInt,
        'version.incremental': data.version.incremental,
        'version.codename': data.version.codename,
        'version.baseOS': data.version.baseOS,
        'board': data.board,
        'bootloader': data.bootloader,
        'brand': data.brand,
        'device': data.device,
        'display': data.display,
        'fingerprint': data.fingerprint,
        'hardware': data.hardware,
        'host': data.host,
        'id': data.id,
        'manufacturer': data.manufacturer,
        'model': data.model, // e.g. "Moto G (4)"
        'product': data.product,
        'supported32BitAbis': data.supported32BitAbis,
        'supported64BitAbis': data.supported64BitAbis,
        'supportedAbis': data.supportedAbis,
        'tags': data.tags,
        'type': data.type,
        'isPhysicalDevice': data.isPhysicalDevice,
        'androidId': data.androidId, // UUID on Android
        'systemFeatures': data.systemFeatures,
      },
    );
    return deviceInfoModel;
  }

  static DeviceInfoModel _readIosDeviceInfo(IosDeviceInfo data) {
    DeviceInfoModel deviceInfoModel = DeviceInfoModel(
      applicationGUID: data.identifierForVendor,
      deviceModelFullName: '${data.name} ${data.model})',
      osVersion: data.systemVersion,
      allInfo: <String, dynamic>{
        'name': data.name,
        'systemName': data.systemName,
        'systemVersion': data.systemVersion, //OS Version
        'model': data.model,
        'localizedModel': data.localizedModel,
        'identifierForVendor': data.identifierForVendor, //UUID for iOS
        'isPhysicalDevice': data.isPhysicalDevice,
        'utsname.sysname:': data.utsname.sysname,
        'utsname.nodename:': data.utsname.nodename,
        'utsname.release:': data.utsname.release,
        'utsname.version:': data.utsname.version,
        'utsname.machine:': data.utsname.machine, // e.g. "iPod7,1"
      },
    );
    return deviceInfoModel;
  }
}
