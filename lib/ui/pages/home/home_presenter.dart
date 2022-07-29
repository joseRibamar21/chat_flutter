import '../../../domain/entities/entities.dart';

abstract class HomePresenter {
  Stream<String> get nameStream;
  Stream<List<RoomEntity>> get listRoomStream;
  Stream<String?> get navigatorStream;

  void inicialization();
  Future<void> saveRooms(String name, String? password, String? master);
  Future<void> searchRoom(String link);
  Future<void> loadRooms();
  void deleteRoom(String name, String password);
  void goChat(RoomEntity room);
  void goRegister();
}
