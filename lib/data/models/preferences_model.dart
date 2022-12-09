import '../../domain/entities/entities.dart';

class PreferencesModel {
  final String nick;
  final String hash;
  final String password;
  final int timer;
  final int theme;

  PreferencesModel(
      {required this.nick,
      required this.password,
      required this.timer,
      required this.hash,
      required this.theme});

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    var data = PreferencesModel(
      nick: json['nick'],
      hash: json['hash'],
      password: json['password'],
      timer: json['timer'],
      theme: json['theme'],
    );

    return data;
  }

  Map<String, dynamic> toJson() => {
        "nick": nick,
        "hash": hash,
        "password": password,
        "timer": timer,
        "theme": theme
      };

  PreferencesEntity toEntity() => PreferencesEntity(
      nick: nick, hash: hash, password: password, timer: timer, theme: theme);
}
