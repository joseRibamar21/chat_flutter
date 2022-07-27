import 'package:get_storage/get_storage.dart';

import '../../domain/usecase/usecase.dart';

class GetLocalStorage implements LocalStorage {
  final GetStorage storage;
  final String key;
  GetLocalStorage({required this.storage, required this.key});

  @override
  Future<bool> save(String value) async {
    try {
      await storage.write(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> read() async {
    try {
      var readData = await storage.read(key);
      return readData;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> delete() async {
    try {
      await storage.remove(key);
      return true;
    } catch (e) {
      return false;
    }
  }
}
