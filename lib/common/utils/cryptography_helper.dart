import 'package:encrypt/encrypt.dart';

class CryptographyHelper {
  static Key _key = Key.fromUtf8("T527jKLYuPXUstrwR9jhJrVMyn6bK7aT");
  static IV _iv = IV.fromBase64("YFpyYr8YNuVddycR");
  static final encrypter = Encrypter(AES(_key));

  CryptographyHelper() {
    if (_key == null || _iv == null) {
      _key = Key.fromLength(32);
      _iv = IV.fromLength(16);
    }
  }

  static encryptAES(String text) {
    final encrypted = encrypter.encrypt(text, iv: _iv);
    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted;
  }

  static decryptAES(text) {
    var decrypted = encrypter.decrypt(
        text is Encrypted
            ? text // decrypt from Encrypted value
            : Encrypted.fromBase64(text.base64) // decrypt from String base64
        ,
        iv: _iv);
    print(decrypted);
    return decrypted;
  }
}
