import 'dart:convert';

import '../../domain/entities/entities.dart';

class RoomModel {
  final String name;
  final String password;
  final String master;
  RoomModel({required this.name, required this.password, required this.master});

  factory RoomModel.fromJson(dynamic json) {
    Map<String, dynamic> data;
    if (json.runtimeType == String) {
      data = jsonDecode(json);
    } else {
      data = json;
    }
    return RoomModel(
        name: data['name'] ?? "",
        password: data['password'] ?? "",
        master: data['master'] ?? "");
  }

  factory RoomModel.fromEntity(RoomEntity entity) => RoomModel(
      name: entity.name, password: entity.password, master: entity.master);

  Map<String, dynamic> toJson() =>
      {"name": name, "password": password, "master": master};

  RoomEntity toEntity() =>
      RoomEntity(name: name, password: password, master: master);
}
