abstract class RegisterPresenter {
  Stream<bool> get isLoading;
  Stream<bool> get isValidStream;
  Stream<String> get navigationStream;
  Stream<String?> get nameErrorStream;
  Stream<String?> get codeErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<String> get uiErrorStream;

  Future<bool> register();

  Future<bool> verifyCode();

  void validadeCode(String value);

  void validadeName(String value);

  void validadePassword(String value);

  void inicialization();
}
