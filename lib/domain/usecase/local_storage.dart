abstract class LocalStorage {
  Future<bool> save(String value);
  Future<dynamic> read();
  Future<bool> delete();
}
