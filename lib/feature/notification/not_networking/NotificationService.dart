import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // طلب الإذن بالإشعارات
    NotificationSettings settings = await _messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("🔔 Notification Permission Granted");
    }

    // الاشتراك في التوبيك "allUsers"
    await _messaging.subscribeToTopic("allUsers");
    print("✅ Subscribed to allUsers topic");

    // الاستماع للإشعارات أثناء فتح التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 New Notification: ${message.notification?.title}");
    });

    // عند الضغط على الإشعار بعد إغلاق التطبيق
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔗 Notification Clicked: ${message.data}");
    });
  }
}
