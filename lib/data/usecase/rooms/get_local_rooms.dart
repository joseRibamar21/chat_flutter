import 'dart:convert';
import 'dart:math';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecase/usecase.dart';
import '../../models/models.dart';

class GetLocalRooms implements LocalRoom {
  final LocalStorage storage;

  GetLocalRooms({required this.storage});

  @override
  Future<bool> delete(RoomEntity room) async {
    try {
      RoomsEntity rooms = RoomsEntity(listRoom: []);
      String? data = await storage.read();
      if (data != null) {
        rooms = RoomsModel.fromJson(jsonDecode(data)).toEntity();
        rooms.listRoom.removeWhere((element) =>
            element.name == room.name && element.password == room.password);
      }

      var json = RoomsModel.fromEntity(rooms).toJson();
      storage.save(jsonEncode(json));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAll() async {
    try {
      await storage.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<RoomsEntity?> listOfRooms() async {
    try {
      var data = await storage.read();
      return RoomsModel.fromJson(jsonDecode(data)).toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> newRoom(String nameRoom, String master) async {
    try {
      var rng = Random();
      var nName = nameRoom;
      nName = nameRoom.replaceAll(" ", "_");
      String password = rng.nextInt(999999999).toString();
      RoomsEntity rooms = RoomsEntity(listRoom: []);
      String? data = await storage.read();

      if (data != null) {
        rooms = RoomsModel.fromJson(jsonDecode(data)).toEntity();
      }
      rooms.listRoom
          .add(RoomEntity(name: nName, password: password, master: master));
      var json = RoomsModel.fromEntity(rooms).toJson();
      await storage.save(jsonEncode(json));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> save(RoomEntity room) async {
    try {
      RoomsEntity rooms = RoomsEntity(listRoom: []);
      String? data = await storage.read();

      if (data != null) {
        rooms = RoomsModel.fromJson(jsonDecode(data)).toEntity();
      }
      rooms.listRoom.add(room);
      var json = RoomsModel.fromEntity(rooms).toJson();
      await storage.save(jsonEncode(json));
      return true;
    } catch (e) {
      return false;
    }
  }
}
