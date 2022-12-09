import 'dart:convert';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecase/usecase.dart';
import '../../err/err.dart';

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
        room.password.isNotEmpty &&
        room.master.isNotEmpty) {
      return _mask(
          "${room.master}.${room.name}.${room.password}.${room.expirateAt}");
    } else {
      return "Erro ao gerar link, dados inválidos";
    }
  }

  @override
  RoomEntity? getRoomLink(String room) {
    if (room.isNotEmpty) {
      String link = _unmask(room);
      List<String> roomlink = link.split(".");
      print(roomlink);
      try {
        RoomEntity roomEntity = RoomEntity(
            master: roomlink[0],
            name: roomlink[1],
            password: roomlink[2],
            expirateAt: roomlink[3]);
        return roomEntity;
      } catch (e) {
        throw InternalErros.invalidadeData;
      }
    } else {
      return null;
    }
  }
}
