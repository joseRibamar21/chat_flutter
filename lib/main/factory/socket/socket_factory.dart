import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/socket/socket.dart';
import '../../../infra/infra.dart';

String socketUrl = 'http://143.244.150.213:3000';

SocketClient makeSocketIO() {
  return SocketIOAdapater(
      socket: io.io(socketUrl, <String, dynamic>{
    'transports': ['websocket']
  }));
}
