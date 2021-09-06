import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future setSecureData(String key, String value) async =>
      await _storage.write(key: key, value: value);

  static Future<String> getSecureData(String key) async => await _storage.read(key: key);

  static Future deleteSecureData(String key) async => _storage.delete(key: key);

  static Future deleteAll() async => _storage.deleteAll();

  static Future setUserCredentials(String email, String password) async {
    setSecureData(Constants.skEmail, email);
    setSecureData(Constants.skPassword, password);
  }
}
