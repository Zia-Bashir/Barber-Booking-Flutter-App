import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';

@override
Future<void> initState() async {
  var fcmServices = FcmServices();
  fcmServices.notificationInit();
}

//todo ------------------ FCM Services Class ------------------

class FcmServices {
  var fcmServerKey = '';

  //* ------------------ Generate FCM Device Token ------------------

  generateFCMDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessaging.getToken();

    return (deviceToken == null) ? "" : deviceToken;
  }

  //* ------------------ Notification Initiliazed ------------------

  notificationInit() async {
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

  // listen background FCM

  listenbackgroundFCM(RemoteMessage message) {
    print("FCM background message");

    var title = message.notification!.title;
    var body = message.notification!.body;
    displyNotification(title: title.toString(), body: body.toString());
  }

  //* ------------------ Local Notifications for Android and iOS ------------------

  //* ------------------ Display Local Notification ------------------

  displyNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "test",
      "test",
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
}
