import 'dart:convert';

import '../entities/entities.dart';

class BodyModel {
  final String message;
  final int connecting;
  BodyModel({required this.message, required this.connecting});

  factory BodyModel.fromJson(dynamic json) {
    Map<String, dynamic> data;
    if (json.runtimeType == String) {
      data = jsonDecode(json);
    } else {
      data = json;
    }
    return BodyModel(message: data['message'], connecting: data["connecting"]);
  }

  factory BodyModel.fromEntity(BodyEntity entity) =>
      BodyModel(message: entity.message, connecting: entity.connecting);

  Map<String, dynamic> toJson() =>
      {"message": message, "connecting": connecting};

  BodyEntity toEntity() => BodyEntity(message: message, connecting: connecting);
}
