import '../../domain/entities/entities.dart';

class PreferencesModel {
  final String nick;
  final int timer;

  PreferencesModel({
    required this.nick,
    required this.timer,
  });

  factory PreferencesModel.fromJson(Map<String, dynamic>? json) {
    var data = PreferencesModel(
      nick: json!['nick'],
      timer: json['timer'],
    );

    return data;
  }

  Map<String, dynamic> toJson() => {"nick": nick, "timer": timer};

  PreferencesEntity toEntity() => PreferencesEntity(nick: nick, timer: timer);
}
