import 'dart:convert';

import '../../domain/entities/entities.dart';
import '../../infra/cache/cache.dart';
import '../models/models.dart';

class RoomsStorage {
  final SecureStorage secureStorage = SecureStorage();

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
    try {
      var data = await secureStorage.readSecureData('rooms');
      return RoomsModel.fromJson(data).toEntity();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
