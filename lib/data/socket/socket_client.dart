abstract class SocketClient {
  void connectRoom(String room, String user);
  bool desconect();
  Future<bool> reconnect();
  void sendMenssage(String value);
  void listenMessagens(Function(dynamic) message);
  void listenDesconect(Function(dynamic) error);
}
