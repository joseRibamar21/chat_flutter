class PreferencesEntity {
  /// Nome Fantasia do usuario
  final String nick;

  final String password;

  /// Tempo padrao do timer de apagar as mensagens
  final int timer;

  /// Tema que inicializará com o app;
  final int theme;

  PreferencesEntity(
      {required this.nick,
      required this.password,
      required this.timer,
      required this.theme});
}
