import '../../domain/entities/entities.dart';

class PreferencesModel {
  final String nick;
  final String password;
  final int timer;
  final int theme;

  PreferencesModel(
      {required this.nick,
      required this.password,
      required this.timer,
      required this.theme});

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    var data = PreferencesModel(
        nick: json['nick'],
        password: json['password'],
        timer: json['timer'],
        theme: json['theme']);

    return data;
  }

  Map<String, dynamic> toJson() =>
      {"nick": nick, "password": password, "timer": timer, "theme": theme};

  PreferencesEntity toEntity() => PreferencesEntity(
      nick: nick, password: password, timer: timer, theme: theme);
}
