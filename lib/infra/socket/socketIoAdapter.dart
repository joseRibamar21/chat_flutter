import 'package:socket_io_client/socket_io_client.dart';

import '../../data/socket/socket.dart';

class SocketIOAdapater implements SocketClient {
  Socket socket;
  SocketIOAdapater({required this.socket});

  @override
  void connectRoom(String room, dynamic user) {
    socket.emit('joinRoom', {"username": user, 'room': room});
  }

  @override
  bool desconect() {
    socket.close();
    if (socket.id == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void listenDesconect(Function(dynamic) error) {
    socket.onError((data) {
      error.call(data);
    });
  }

  @override
  void listenMessagens(Function(dynamic) message) {
    socket.on('message', (data) {
      message.call(data);
    });
  }

  @override
  Future<bool> reconnect() async {
    int count = 0;

    while (socket.id == null) {
      if (count >= 5) return false;
      if (socket.connected) {
        return true;
      } else {
        await Future.delayed(
            const Duration(milliseconds: 200), () => socket = socket.connect());
        count += 1;
      }
    }
    return false;
  }

  @override
  void sendMenssage(Map<String, dynamic> value) {
    socket.emit('chatMessage', value);
  }

  @override
  bool get isConnect => socket.connected;
}
