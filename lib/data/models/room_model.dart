import 'dart:convert';

import '../../domain/entities/entities.dart';

class RoomModel {
  final String name;
  final String password;
  RoomModel({required this.name, required this.password});

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
    );
  }

  factory RoomModel.fromEntity(RoomEntity entity) =>
      RoomModel(name: entity.name, password: entity.password);

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
      };

  RoomEntity toEntity() => RoomEntity(name: name, password: password);
}
