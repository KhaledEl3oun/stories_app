import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket() {
    socket = IO.io('http://194.164.77.238:8002', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // استمع للحدث 'contentAdded'
    socket.on('contentAdded', (data) {
      print("🔔 New Content Added: $data");
      // هنا ممكن تعرض إشعار داخلي أو تحدّث الـ UI
    });

    socket.onConnect((_) => print("✅ Connected to WebSocket"));
    socket.onDisconnect((_) => print("❌ Disconnected from WebSocket"));
  }

  void dispose() {
    socket.disconnect();
  }
}
