import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';

//todo ------------------ FCM Services Class ------------------

class FcmServices {
  static var fcmServerKey = '';

  //* ------------------ Generate FCM Device Token ------------------

  static generateFCMDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessaging.getToken();

    return (deviceToken == null) ? "" : deviceToken;
  }

  //* ------------------ Notification Initiliazed ------------------

  static notificationInit() async {
    //= ------------------ Inintialized Android and iOS settings ------------------

    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    bool? inintialized =
        await notificationsPlugin.initialize(initializationSettings);
    log("Notification -------------------------------------------:$inintialized");
  }

  //// - ====================================================================== -

  //* ------------------ Display Local Notification ------------------

  static displyNotification(
      {required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "thebarberapp",
      "thebarberappchannel",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      enableVibration: true,
    );
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    //* ------------------ Show Notification ------------------

    await notificationsPlugin.show(
      1,
      title,
      body,
      NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
      ),
    );
  }
  //// - ====================================================================== -

  //* ------------------ Terminate State Notification ------------------

  static terminateNotification() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");

        if (message != null) {
          var title = message.notification!.title;
          var body = message.notification!.body;
          displyNotification(title: title!, body: body!);
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
  }

  //// - ====================================================================== -

  //* ------------------ Foreground Notification ------------------

  static foregroundNotification() {
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          if (message.notification != null) {
            var title = message.notification!.title;
            var body = message.notification!.body;
            displyNotification(title: title!, body: body!);

            print("message.data22 ${message.data['_id']}");
          }
        }
      },
    );
  }

  //// - ====================================================================== -

  //* ------------------ Background Notification ------------------

  static backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          var title = message.notification!.title;
          var body = message.notification!.body;
          displyNotification(title: title!, body: body!);

          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
}
