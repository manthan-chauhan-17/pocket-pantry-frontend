// import 'dart:developer' as dev;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:pocket_pantry_frontend/main.dart';
// import 'package:pocket_pantry_frontend/services/notification_service/notification_service.dart';
// import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';

// class FirebaseService {
//   FirebaseService._();
//   static final FirebaseService firebaseService = FirebaseService._();
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   Future<void> initializeFirebaseMessaging() async {
//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage message) async {
//         dev.log(
//             "Foreground notification received Data On Message APP: ${message.data}",
//             name: "Firebase");
//         await NotificationService.showNotification(message);
//         if (message.data['title'] == "uploadSyncData") {}
//       },
//     );

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       dev.log(
//           "Notification Clicked (Background) notification received Data: ${message.data}",
//           name: "Firebase");

//       await NotificationService.showNotification(message);
//       // NotificationService.handleNotificationData(message.data);
//       //  NotificationService.(message);
//     });

//     await FirebaseMessaging.instance.getInitialMessage().then(
//       (message) async {
//         if (message != null) {
//           SnackBar snackBar = SnackBar(
//             content: Text("Notification Clicked: ${message.data}"),
//             duration: const Duration(seconds: 2),
//           );
//           ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
//               .showSnackBar(snackBar);
//           await NotificationService.showNotification(message);
//         } else {
//           SnackBar snackBar = SnackBar(
//             content: Text("Notification Clicked: $message"),
//             duration: const Duration(seconds: 5),
//           );
//           ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
//               .showSnackBar(snackBar);
//         }
//       },
//     );
//   }

//   getFCMToken() async {
//     String? fcmToken = "";
//     fcmToken = await _firebaseMessaging.getToken();
//     dev.log(fcmToken!, name: "FCM Token");
//     MySharedPreference.setFcmToken(fcmToken);
//     return fcmToken;
//   }

// // static Future<void> firebaseInitializeApp() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await dotenv.load();
// //   await Firebase.initializeApp(
// //     options: FirebaseOptions(
// //       apiKey: dotenv.env['FIREBASE_API_KEY']!,
// //       appId: Platform.isAndroid
// //           ? dotenv.env['FIREBASE_ANDROID_APPID']!
// //           : dotenv.env['FIREBASE_IOS_APPID']!,
// //       messagingSenderId: dotenv.env['FIREBASE_SENDER_ID']!,
// //       projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
// //     ),
// //   );
// // }
// }
