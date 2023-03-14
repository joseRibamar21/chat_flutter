class PreferencesEntity {
  /// Nome Fantasia do usuario
  final String nick;

  /// Identificador unico do usuario
  final String hash;

  final String password;

  /// Tempo padrao do timer de apagar as mensagens
  final int timer;

  /// Tema que inicializará com o app;
  final int theme;

  /// Codigo de desbloqueio do app;
  final String code;

  /// Codigo de desbloqueio do app;
  final bool isDeveloper;

  /// Tempo de expiração do codigo;
  final String expirationCode;

  PreferencesEntity({
    required this.code,
    required this.nick,
    required this.hash,
    required this.password,
    required this.timer,
    required this.theme,
    required this.isDeveloper,
    required this.expirationCode,
  });
}
