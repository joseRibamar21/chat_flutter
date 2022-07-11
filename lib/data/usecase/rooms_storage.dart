import 'dart:convert';

import '../../domain/entities/entities.dart';
import '../../infra/cache/cache.dart';
import '../models/models.dart';
import 'encrypt_message.dart';

class RoomsStorage {
  final SecureStorage secureStorage = SecureStorage();
  final EncryptMessage encryptMessage = EncryptMessage();

  Future<void> saveRoom(String name, String password) async {
    try {
      RoomsEntity rooms = RoomsEntity(listRoom: []);
      String? data = await secureStorage.readSecureData('rooms');

      if (data != null) {
        rooms = RoomsModel.fromJson(jsonDecode(data)).toEntity();
      }
      rooms.listRoom.add(RoomEntity(name: name, password: password));

      var json = RoomsModel.fromEntity(rooms).toJson();
      secureStorage.writeSecureData('rooms', jsonEncode(json));
    } catch (e) {
      print(e);
    }
  }

  Future<RoomsEntity?> getRooms() async {
    var data = await secureStorage.readSecureData('rooms');
    return RoomsModel.fromJson(jsonDecode(data)).toEntity();
  }

  Future<void> deleteRoom(String name, String password) async {
    try {
      RoomsEntity rooms = RoomsEntity(listRoom: []);
      String? data = await secureStorage.readSecureData('rooms');
      if (data != null) {
        rooms = RoomsModel.fromJson(jsonDecode(data)).toEntity();
        rooms.listRoom.removeWhere(
            (element) => element.name == name && element.password == password);
      }

      var json = RoomsModel.fromEntity(rooms).toJson();
      secureStorage.writeSecureData('rooms', jsonEncode(json));
    } catch (e) {
      print(e);
    }
  }

  String? getLinkRoom(RoomEntity room) {
    if (room.name.isNotEmpty && room.password.isNotEmpty) {
      return encryptMessage.encrypt("${room.name}-${room.password}");
    } else {
      return "";
    }
  }

  RoomEntity? getRoomFromLink(String room) {
    if (room.isNotEmpty) {
      String link = encryptMessage.dencrypt(room);
      List<String> roomlink = link.split("-");
      RoomEntity roomEntity =
          RoomEntity(name: roomlink[0], password: roomlink[1]);
      return roomEntity;
    } else {
      return null;
    }
  }
}
