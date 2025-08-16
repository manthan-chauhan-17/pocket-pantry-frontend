import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseService firebaseService = FirebaseService._();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  // Future<void> initializeFirebaseMessaging() async {
  //   FirebaseMessaging.onMessage.listen(
  //     (RemoteMessage message) async {
  //       dev.log(
  //           "Foreground notification received Data On Message APP: ${message.data}",
  //           name: "Firebase");
  //       await NotificationService.showNotification(message);
  //     },
  //   );

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //     dev.log(
  //         "Notification Clicked (Background) notification received Data: ${message.data}",
  //         name: "Firebase");

  //     await NotificationService.showNotification(message);
  //     // NotificationService.handleNotificationData(message.data);
  //     //  NotificationService.(message);
  //   });

  //   await FirebaseMessaging.instance.getInitialMessage().then(
  //     (message) async {
  //       if (message != null) {
  //         SnackBar snackBar = SnackBar(
  //           content: Text("Notification Clicked: ${message.data}"),
  //           duration: const Duration(seconds: 2),
  //         );
  //         ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
  //             .showSnackBar(snackBar);
  //         await NotificationService.showNotification(message);
  //       } else {
  //         SnackBar snackBar = SnackBar(
  //           content: Text("Notification Clicked: $message"),
  //           duration: const Duration(seconds: 5),
  //         );
  //         ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
  //             .showSnackBar(snackBar);
  //       }
  //     },
  //   );
  // }

  getFCMToken() async {
    String? fcmToken = "";
    fcmToken = await _firebaseMessaging.getToken();
    await MySharedPreference.setFcmToken(fcmToken ?? '');
    return fcmToken;
  }
}
