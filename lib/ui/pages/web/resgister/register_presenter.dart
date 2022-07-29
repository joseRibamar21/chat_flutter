abstract class RegisterPresenterWeb {
  Stream<bool> get isLoading;
  Stream<bool> get isValidStream;
  Stream<String?> get navigationStream;
  Stream<String?> get nameErrorStream;
  Stream<String?> get uiErrorStream;

  void goToChatLink();
  void goToChatGenerate();

  void validadeName(String value);
  void validadeLink(String value);
}
