abstract class RegisterPresenter {
  Stream<bool> get isLoading;
  Stream<bool> get isValidStream;
  Stream<String> get navigationStream;
  Stream<String?> get nameErrorStream;
  Stream<String> get uiErrorStream;

  Future<bool> register();

  void validadeName(String value);

  void inicialization();
}
