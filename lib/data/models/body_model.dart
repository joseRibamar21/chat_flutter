import 'dart:convert';

import '../../domain/entities/entities.dart';

class BodyModel {
  final String? id;
  final String? message;
  final int function;
  final int sendAt;
  BodyModel(
      {required this.id,
      required this.message,
      required this.function,
      required this.sendAt});

  factory BodyModel.fromJson(dynamic json) {
    Map<String, dynamic> data;
    if (json.runtimeType == String) {
      data = jsonDecode(json);
    } else {
      data = json;
    }
    return BodyModel(
        id: data['id'] ?? "",
        message: data['message'] ?? "",
        function: data["function"] ?? -1,
        sendAt: data['sendAt'] ?? 0);
  }

  factory BodyModel.fromEntity(BodyEntity entity) => BodyModel(
      id: entity.id,
      message: entity.message,
      function: entity.function,
      sendAt: entity.sendAt);

  Map<String, dynamic> toJson() =>
      {"id": id, "message": message, "function": function, "sendAt": sendAt};

  BodyEntity toEntity() =>
      BodyEntity(message: message, function: function, id: id, sendAt: sendAt);
}
