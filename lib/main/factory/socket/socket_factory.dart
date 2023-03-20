import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../data/socket/socket.dart';
import '../../../infra/infra.dart';

String socketUrl = 'http://206.81.11.96:3000/';

SocketClient makeSocketIO() {
  return SocketIOAdapater(
    socket: io.io(
        socketUrl,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build()),
  );
}
