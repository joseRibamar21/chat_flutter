abstract class RegisterPresenter {
  Stream<String> get navigationStream;
  Stream<String> get uiErrorStream;
  Stream<bool> get isLoading;

  void register();

  void validadeName(String value);

  void inicialization();
}
