abstract class SocketClient {
  void init();
  bool desconect();
  Future<bool> reconnect();

  void connectRoom(String room, dynamic user);
  void sendMenssage(Map<String, dynamic> value, String username, String room);
  void listenMessagens(Function(dynamic) message);
  void listenDesconect(Function(dynamic) error);

  bool get isConnect;
}
