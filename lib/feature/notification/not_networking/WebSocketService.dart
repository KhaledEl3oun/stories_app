import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://194.164.77.238:8002', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('✅ WebSocket Connected');
    });

    // استماع لـ event `contentAdded`
    socket.on('contentAdded', (data) {
      print('🔔 New content added: $data');
    });

    socket.onDisconnect((_) {
      print('❌ WebSocket Disconnected');
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
