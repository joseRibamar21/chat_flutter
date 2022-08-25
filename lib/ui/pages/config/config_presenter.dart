abstract class ConfigPresenter {
  void logoff();

  Future<void> updateTime(int h, int m);

  Future<Map<String, dynamic>> getTime();
}
