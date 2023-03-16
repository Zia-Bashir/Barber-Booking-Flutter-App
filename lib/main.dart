import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/firebase_options.dart';
import 'package:the_barber/src/common/firebase/fcm_services.dart';
import 'package:the_barber/src/common/routes/routes.dart';
import 'package:the_barber/src/common/services/storage.dart';
import 'package:the_barber/src/common/theme/theme_index.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './src/common/helper/dependicies.dart' as dep;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
//* ------------------ FCM Background Message ------------------
Future<void> backgroundHandler(RemoteMessage message) async {
  var title = message.notification!.title;
  var body = message.notification!.body;
  FcmServices.displyNotification(title: title!, body: body!);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //* ------------------ FCM Background Message ------------------
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  //? --- Getx Dependecy Injection ---
  dep.initState();

  //* --- FCM Services ---
  FcmServices.notificationInit();

  //* --- Storage Services ---
  StorageServices.to.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Barber',
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.lightTheme,
          themeMode: ThemeMode.light,
          home: child,
          getPages: AppPages.routes,
        );
      },
      // child: const HomeScreen(),
    );
  }
}
