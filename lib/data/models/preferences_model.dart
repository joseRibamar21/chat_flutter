import '../../domain/entities/entities.dart';

class PreferencesModel {
  final String nick;
  final String hash;
  final String password;
  final int timer;
  final int theme;
  final String code;
  final bool isDeveloper;

  PreferencesModel({
    required this.nick,
    required this.password,
    required this.timer,
    required this.hash,
    required this.theme,
    required this.code,
    required this.isDeveloper,
  });

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    var data = PreferencesModel(
      code: json['code'],
      nick: json['nick'],
      hash: json['hash'],
      password: json['password'],
      timer: json['timer'],
      theme: json['theme'],
      isDeveloper: json['isDeveloper'],
    );

    return data;
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "nick": nick,
        "hash": hash,
        "password": password,
        "timer": timer,
        "theme": theme,
        "isDeveloper": isDeveloper
      };

  PreferencesEntity toEntity() => PreferencesEntity(
      code: code,
      nick: nick,
      hash: hash,
      password: password,
      timer: timer,
      theme: theme,
      isDeveloper: isDeveloper);
}
