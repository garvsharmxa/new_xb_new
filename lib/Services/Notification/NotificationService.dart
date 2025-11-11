import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final RxInt notificationCount = 0.obs;
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions for iOS
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final plugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    
    if (plugin != null) {
      await plugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
    // You can navigate to specific screens based on payload
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'xb_channel',
      'XpressBites Notifications',
      channelDescription: 'Notifications for XpressBites orders',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      color: Color(0xFFC2262D),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      title,
      body,
      notificationDetails,
      payload: payload,
    );

    // Add to local notification list
    _addNotification(title, body);
  }

  void _addNotification(String title, String body) {
    notifications.insert(
      0,
      NotificationItem(
        title: title,
        body: body,
        timestamp: DateTime.now(),
      ),
    );
    notificationCount.value = notifications.length;
    
    // Keep only last 50 notifications
    if (notifications.length > 50) {
      notifications.removeRange(50, notifications.length);
    }
  }

  Future<void> showOrderPlacedNotification(String orderId) async {
    await showNotification(
      title: 'Order Placed Successfully! 🎉',
      body: 'Your order #${orderId.substring(orderId.length - 8)} has been placed',
      payload: 'order:$orderId',
    );
  }

  Future<void> showOrderConfirmedNotification(String orderId) async {
    await showNotification(
      title: 'Order Confirmed ✅',
      body: 'Restaurant has confirmed your order #${orderId.substring(orderId.length - 8)}',
      payload: 'order:$orderId',
    );
  }

  Future<void> showOrderPreparingNotification(String orderId) async {
    await showNotification(
      title: 'Preparing Your Food 👨‍🍳',
      body: 'Your delicious meal is being prepared',
      payload: 'order:$orderId',
    );
  }

  Future<void> showOrderReadyNotification(String orderId) async {
    await showNotification(
      title: 'Order Ready for Pickup! 🎊',
      body: 'Your order #${orderId.substring(orderId.length - 8)} is ready',
      payload: 'order:$orderId',
    );
  }

  Future<void> showOrderCompletedNotification(String orderId) async {
    await showNotification(
      title: 'Order Completed! 🌟',
      body: 'Thank you for ordering with XpressBites',
      payload: 'order:$orderId',
    );
  }

  void clearNotificationCount() {
    notificationCount.value = 0;
  }

  void markAllAsRead() {
    notifications.clear();
    notificationCount.value = 0;
  }
}

class NotificationItem {
  final String title;
  final String body;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });
}
