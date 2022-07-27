import '../entities/entities.dart';

abstract class LocalRoom {
  Future<bool> newRoom(String nameRoom);

  Future<bool> save(RoomEntity room);

  Future<dynamic> listRoom();

  Future<bool> delete(RoomEntity room);

  Future<bool> deleteAll();
}
