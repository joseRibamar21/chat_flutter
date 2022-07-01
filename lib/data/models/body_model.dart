import 'dart:convert';

import '../entities/entities.dart';

class BodyModel {
  final String id;
  final String? message;
  final int function;
  BodyModel({required this.id, required this.message, required this.function});

  factory BodyModel.fromJson(dynamic json) {
    Map<String, dynamic> data;
    if (json.runtimeType == String) {
      data = jsonDecode(json);
    } else {
      data = json;
    }
    return BodyModel(
        id: data['id'], message: data['message'], function: data["function"]);
  }

  factory BodyModel.fromEntity(BodyEntity entity) => BodyModel(
      id: entity.id, message: entity.message, function: entity.function);

  Map<String, dynamic> toJson() =>
      {"id": id, "message": message, "function": function};

  BodyEntity toEntity() =>
      BodyEntity(message: message, function: function, id: id);
}
