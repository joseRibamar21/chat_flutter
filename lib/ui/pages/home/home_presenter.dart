import '../../../domain/entities/entities.dart';

abstract class HomePresenter {
  Stream<String> get nameStream;
  Stream<List<RoomEntity>> get listRoomStream;

  void inicialization();
  Future<void> saveRooms(String name, String? password);
  Future<void> searchRoom(String link);
  Future<void> loadRooms();
  void deleteRoom(String name, String password);
}
