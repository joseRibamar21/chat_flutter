import '../entities/entities.dart';

abstract class LocalRoom {
  ///Função para salvar um nova sala
  ///Parametros: [nameRoom] - nome da sala, [master] - codinome do usuario que está criando
  Future<bool> newRoom(String nameRoom, String master);

  Future<bool> save(RoomEntity room);

  Future<dynamic> listOfRooms();

  Future<bool> delete(RoomEntity room);

  Future<bool> deleteAll();
}
