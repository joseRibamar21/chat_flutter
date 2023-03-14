import '../../../domain/entities/entities.dart';

abstract class HomePresenter {
  Stream<UserEntity?> get userStream;
  Stream<List<RoomEntity>> get listRoomStream;
  Stream<String?> get navigatorStream;
  Stream<bool> get isSeachingStream;
  Stream<String?> get uiErrorStream;

  void inicialization();
  Future<void> createRoom(String name);
  Future<void> saveRooms(RoomEntity room);
  Future<void> enterRoom(String code);
  Future<void> loadRooms();
  Future<bool> accountValid();

  void deleteRoom(RoomEntity room);
  void goChat(RoomEntity room);
  void goTo(String route);
  void filterRoom(String value);
  void returnFilterRoom();
  void requiredContacts(Function f);

  void seaching(bool value);

  bool validadePassword(String password);
  Future<String> getCodeRoom(RoomEntity room);
}
