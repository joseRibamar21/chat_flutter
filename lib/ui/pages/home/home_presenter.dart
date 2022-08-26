import '../../../domain/entities/entities.dart';

abstract class HomePresenter {
  Stream<String> get nameStream;
  Stream<List<RoomEntity>> get listRoomStream;
  Stream<String?> get navigatorStream;
  Stream<bool> get isSeachingStream;
  Stream<String?> get uiErrorStream;

  void inicialization();
  Future<void> saveRooms(String name, String? master);
  Future<void> enterRoom(String link);
  Future<void> loadRooms();
  void deleteRoom(String name, String password);
  void goChat(RoomEntity room);
  void goTo(String route);
  void filterRoom(String value);
  void returnFilterRoom();
  void requiredContacts(Function f);

  void seaching(bool value);

  bool validadePassword(String password);
  Future<String> getLinkRoom(RoomEntity room);
}
