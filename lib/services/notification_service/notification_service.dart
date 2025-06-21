// import 'dart:convert';
// import 'dart:developer' as dev;
// import 'dart:math';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// @pragma('vm:entry-point')
// void onBackgroundNotificationClick(NotificationResponse response) {
//   dev.log("[BACKGROUND] Notification Clicked: ${response.payload}");
// }

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('ic_notification_icon');
//     DarwinInitializationSettings iosSetting =
//         const DarwinInitializationSettings();
//     InitializationSettings settings =
//         InitializationSettings(android: androidSettings, iOS: iosSetting);

//     await _notificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         dev.log("Local Notification Tapped: ${response.payload}",
//             name: "LocalNotification");
//         if (response.payload != null && response.payload!.isNotEmpty) {
//           Map<String, dynamic> payload = jsonDecode(response.payload!);
//           handleNotificationData(payload);
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: onBackgroundNotificationClick,
//     );
//   }

//   static Future<void> showNotification(RemoteMessage message) async {
//     if (message.data.isEmpty) return;

//     String? imageUrl = message.data['image']; // Image URL from payload

//     BigPictureStyleInformation? bigPicture;

//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       try {
//         final ByteArrayAndroidBitmap largeIcon =
//             await _getByteArrayFromUrl(imageUrl);
//         bigPicture = BigPictureStyleInformation(largeIcon);
//       } catch (e) {
//         dev.log("Error loading image: $e", name: "Notification Error");
//       }
//     }

//     dev.log(message.data.toString(), name: "Called from Notification");

//     AndroidNotificationDetails androidDetails;
//     dev.log(message.data.toString(), name: "Called from Notification");

//     // Check notification type

//     androidDetails = AndroidNotificationDetails(
//       'general_channel',
//       'General Notification',
//       channelDescription: 'Used for general notifications.',
//       importance: Importance.high,
//       enableVibration: true,
//       priority: Priority.high,
//       fullScreenIntent: true,
//       styleInformation: bigPicture,
//       icon: '@mipmap/ic_launcher',
//       channelShowBadge: true,
//     );

//     DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     final NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notificationsPlugin.show(
//       Random().nextInt(1000000),
//       message.data['title'],
//       message.data['body'],
//       platformDetails,
//       payload: jsonEncode(message.data),
//     );
//   }

//   static Future<ByteArrayAndroidBitmap> _getByteArrayFromUrl(String url) async {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       return ByteArrayAndroidBitmap(response.bodyBytes);
//     } else {
//       throw Exception("Failed to load image from $url");
//     }
//   }

//   static void handleNotificationData(Map<String, dynamic> data) {}
// }
