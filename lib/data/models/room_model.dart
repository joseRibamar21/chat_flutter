import 'dart:convert';

import '../../domain/entities/entities.dart';

class RoomModel {
  final String master;
  final String masterHash;
  final String name;
  final String password;
  final String roomHash;
  String? expirateAt;

  RoomModel(
      {required this.master,
      required this.masterHash,
      required this.name,
      required this.password,
      required this.roomHash,
      required this.expirateAt});

  factory RoomModel.fromJson(dynamic json) {
    Map<String, dynamic> data;
    if (json.runtimeType == String) {
      data = jsonDecode(json);
    } else {
      data = json;
    }
    return RoomModel(
      name: data['name'],
      password: data['password'] ?? "",
      master: data['master'],
      masterHash: data['masterHash'],
      roomHash: data['roomHash'],
      expirateAt: data['expirateAt'] ?? "",
    );
  }

  factory RoomModel.fromEntity(RoomEntity entity) => RoomModel(
      name: entity.name,
      password: entity.password,
      master: entity.master,
      masterHash: entity.masterHash,
      roomHash: entity.roomHash,
      expirateAt: entity.expirateAt);

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "master": master,
        "masterHash": masterHash,
        "roomHash": roomHash,
        "expirateAt": expirateAt
      };

  RoomEntity toEntity() => RoomEntity(
      master: master,
      masterHash: masterHash,
      name: name,
      roomHash: roomHash,
      password: password,
      expirateAt: expirateAt);
}
