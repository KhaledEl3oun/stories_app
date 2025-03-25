import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class MyFirebaseMessagingService {
  static Future<void> backgroundHandler(RemoteMessage message) async {
    log("📩 Background Message Received: ${message.messageId}");
  }

  static void init() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }
}
