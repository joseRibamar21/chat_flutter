import 'dart:convert';

import 'package:chat_flutter/domain/entities/entities.dart';

import '../models/models.dart';

/// Função que retorna uma String ja preparado para ser enviado
Map<String, dynamic> prepareSendMessage(
    {required String usarName, required int status, String? message}) {
  //EncryptMessage encryptMessage = EncryptMessage();

  return {
    'username': usarName,
    'text': jsonEncode(BodyModel(
            id: usarName + DateTime.now().microsecondsSinceEpoch.toString(),
            message: message, //encryptMessage.encrypt(message ?? ""),
            function: status,
            sendAt: DateTime.now().microsecondsSinceEpoch)
        .toJson())
  };
}

MessageEntity? getSendMessage({required dynamic event}) {
  if (event['username'] == 'Bot do Jair') {
    return null;
  }

  try {
    //EncryptMessage encryptMessage = EncryptMessage();
    var userName = event['username'];

    var time = event['time'];

    var text = event['text'];

    var message = MessageEntity(
        username: userName,
        text: BodyModel.fromJson(text['text']).toEntity(),
        time: time);
    return message;

    //var message = jsonDecode(event);
    /* print("message: " + message.toString());
    var teste = message['body'];
    print(teste);
    if (teste['function'] != 5) {
      try {
        teste['message'] = teste['message'] != null
            ? teste['message'] //encryptMessage.dencrypt(teste['message'])
            : null;
      } finally {}
    }
    return MessageEntity(
        username: message['username'],
        text: BodyModel.fromJson(teste).toEntity(),
        time: message['time']); */
  } catch (error) {}
  return null;
}