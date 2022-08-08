import 'package:flutter/foundation.dart';
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
    socket.dispose();
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

    socket.onConnectError((data) {
      error.call(data);
    });
    socket.onConnect((data) {});
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
    if (kDebugMode) {
      print("Reconnect");
    }
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

  @override
  void init() {
    socket.connect();
  }
}
