import '../../domain/entities/entities.dart';
import 'encrypt_message.dart';

class RoomsStorage {
  final EncryptMessage encryptMessage = EncryptMessage();

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
      print(link);
      List<String> roomlink = link.split("-");
      RoomEntity roomEntity =
          RoomEntity(name: roomlink[0], password: roomlink[1]);
      return roomEntity;
    } else {
      return null;
    }
  }
}
