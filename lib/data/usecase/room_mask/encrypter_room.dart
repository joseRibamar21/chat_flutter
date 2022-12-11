import 'dart:convert';

import 'package:chat_flutter/data/models/user_model.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecase/usecase.dart';
import '../../err/err.dart';
import '../../models/models.dart';

class EncrypterRoom implements EncryterMessage {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  String? _mask(String message) {
    try {
      return stringToBase64.encode(message);
    } catch (e) {
      return "Error ao gerar url!";
    }
  }

  String _unmask(String message) {
    try {
      return stringToBase64.decode(message);
    } catch (e) {
      return "Error ao ler url";
    }
  }

  @override
  String? getLinkRoom(RoomEntity room) {
    if (room.name.isNotEmpty &&
        room.roomHash.isNotEmpty &&
        room.master.isNotEmpty) {
      return _mask(jsonEncode(RoomModel.fromEntity(room).toJson()));
    } else {
      return "Erro ao gerar link, dados inválidos";
    }
  }

  @override
  RoomEntity? getRoomLink(String room) {
    if (room.isNotEmpty) {
      try {
        String link = _unmask(room);
        RoomEntity roomEntity = RoomModel.fromJson(jsonDecode(link)).toEntity();
        return roomEntity;
      } catch (e) {
        throw InternalErros.invalidadeData;
      }
    } else {
      return null;
    }
  }

  @override
  String? encryterUser(UserEntity user) {
    if (user.name.isNotEmpty && user.hash.isNotEmpty) {
      return _mask(jsonEncode(UserModel.fromEntity(user).toJson()));
    } else {
      return "Erro ao gerar link, dados inválidos";
    }
  }

  @override
  UserEntity? getUserEncryter(String user) {
    if (user.isNotEmpty) {
      try {
        String link = _unmask(user);
        UserEntity roomEntity = UserModel.fromJson(jsonDecode(link)).toEntity();
        return roomEntity;
      } catch (e) {
        throw InternalErros.invalidadeData;
      }
    } else {
      return null;
    }
  }
}
