import 'package:encrypt/encrypt.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecase/usecase.dart';

class EncrypterRoom implements EncryterMessage {
  final _key = Key.fromUtf8('mya32alengthakey123123123123.123');
  final _iv = IV.fromLength(16);

  String? _mask(String message) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(message, iv: _iv);
    return encrypted.base64;
  }

  String _unmask(String message) {
    try {
      final encrypter = Encrypter(AES(_key));
      final decrypted = encrypter.decrypt64(message, iv: _iv);
      return decrypted;
    } catch (e) {
      return "Error";
    }
  }

  @override
  String? getLinkRoom(RoomEntity room) {
    if (room.name.isNotEmpty && room.password.isNotEmpty) {
      return _mask("${room.name}-${room.password}");
    } else {
      return "";
    }
  }

  @override
  RoomEntity? getRoomLink(String room) {
    if (room.isNotEmpty) {
      String link = _unmask(room);
      List<String> roomlink = link.split("-");
      RoomEntity roomEntity =
          RoomEntity(name: roomlink[0], password: roomlink[1]);
      return roomEntity;
    } else {
      return null;
    }
  }
}
