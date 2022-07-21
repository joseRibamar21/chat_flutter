import 'package:get_storage/get_storage.dart';

class SecureStorage {
  final _storage = GetStorage('rooms');
  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key, value);
    return writeData;
  }

  Future readSecureData(String key) async {
    var readData = await _storage.read(key);
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.remove(key);
    return deleteData;
  }
}
