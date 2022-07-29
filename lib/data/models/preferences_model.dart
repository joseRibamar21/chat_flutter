import '../../domain/entities/entities.dart';

class PreferencesModel {
  final String nick;
  final int timer;
  final int theme;

  PreferencesModel(
      {required this.nick, required this.timer, required this.theme});

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    var data = PreferencesModel(
        nick: json['nick'], timer: json['timer'], theme: json['theme']);

    return data;
  }

  Map<String, dynamic> toJson() =>
      {"nick": nick, "timer": timer, "theme": theme};

  PreferencesEntity toEntity() =>
      PreferencesEntity(nick: nick, timer: timer, theme: theme);
}
