import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class DeviceInfoModel {
  String applicationGUID;
  String deviceModelFullName;
  Map<String, dynamic> allInfo;
  DeviceInfoModel({this.applicationGUID, this.deviceModelFullName, this.allInfo});
}

class UserDeviceInfo {
  static DeviceInfoModel deviceData = DeviceInfoModel();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

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

  static DeviceInfoModel _readAndroidBuildData(AndroidDeviceInfo build) {
    DeviceInfoModel deviceInfoModel = DeviceInfoModel(
      applicationGUID: build.androidId,
      deviceModelFullName:
          '${build.manufacturer} ${build.model} (Android ${build.version.release})',
      allInfo: <String, dynamic>{
        'version.securityPatch': build.version.securityPatch,
        'version.sdkInt': build.version.sdkInt,
        'version.release': build.version.release,
        'version.previewSdkInt': build.version.previewSdkInt,
        'version.incremental': build.version.incremental,
        'version.codename': build.version.codename,
        'version.baseOS': build.version.baseOS,
        'board': build.board,
        'bootloader': build.bootloader,
        'brand': build.brand,
        'device': build.device,
        'display': build.display,
        'fingerprint': build.fingerprint,
        'hardware': build.hardware,
        'host': build.host,
        'id': build.id,
        'manufacturer': build.manufacturer,
        'model': build.model, // e.g. "Moto G (4)"
        'product': build.product,
        'supported32BitAbis': build.supported32BitAbis,
        'supported64BitAbis': build.supported64BitAbis,
        'supportedAbis': build.supportedAbis,
        'tags': build.tags,
        'type': build.type,
        'isPhysicalDevice': build.isPhysicalDevice,
        'androidId': build.androidId, // UUID on Android
        'systemFeatures': build.systemFeatures,
      },
    );
    return deviceInfoModel;
  }

  static DeviceInfoModel _readIosDeviceInfo(IosDeviceInfo data) {
    DeviceInfoModel deviceInfoModel = DeviceInfoModel(
      applicationGUID: data.utsname.machine,
      deviceModelFullName: data.identifierForVendor,
      allInfo: <String, dynamic>{
        'name': data.name,
        'systemName': data.systemName,
        'systemVersion': data.systemVersion,
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
