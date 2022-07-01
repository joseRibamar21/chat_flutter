import 'package:encrypt/encrypt.dart';

class EncryptMessage {
  final _key = Key.fromUtf8('mya32alengthakey123123123123.123');
  final _iv = IV.fromLength(16);

  String encrypt(String message) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(message, iv: _iv);
    return encrypted.base64;
  }

  String dencrypt(String message) {
    try {
      final encrypter = Encrypter(AES(_key));
      final decrypted = encrypter.decrypt64(message, iv: _iv);
      return decrypted;
    } catch (e) {
      return "Error";
    }
  }
}
