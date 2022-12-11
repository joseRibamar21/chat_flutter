import '../entities/entities.dart';

abstract class EncryterMessage {
  String? getLinkRoom(RoomEntity room);
  RoomEntity? getRoomLink(String room);
  String? encryterUser(UserEntity user);
  UserEntity? getUserEncryter(String user);
}
