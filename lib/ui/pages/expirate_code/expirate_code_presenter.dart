abstract class ExpirateCodePresenter {
  Stream<String?> get codeErrorStream;
  void validadeCode(String value);
  Future<bool> verifyCode();
}
