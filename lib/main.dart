import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_barber/firebase_options.dart';
import 'package:the_barber/src/common/routes/routes.dart';
import 'package:the_barber/src/common/services/storage.dart';
import 'package:the_barber/src/common/theme/theme_index.dart';

import './src/common/helper/dependicies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //? --- Getx Dependecy Injection ---
  dep.initState();

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
      //child: const AuthScreen(),
    );
  }
}
