abstract class ConfigPresenter {
  void logoff();

  Future<void> updateTime(int h, int m);
  Future<void> updateName(String codiname);

  Future<Map<String, dynamic>> getTime();
  Future<String> getName();
}
