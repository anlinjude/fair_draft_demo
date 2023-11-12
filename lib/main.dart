import 'package:fairdraft/bindings.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/constants/app_theme.dart';
import 'package:fairdraft/pages/SplashPage/splash_page.dart';
import 'package:fairdraft/services/notification_service.dart';
import 'package:fairdraft/services/user_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  NotificationService().init();
  final fcmToken = await _firebaseMessaging.getToken();
  if (kDebugMode) {
    print(fcmToken);
  }
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  await UserService().saveUserFCMToken(fcmToken);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(// navigation bar color
    statusBarColor: AppColor().primaryColor, // status bar color
  ));
  runApp(const MyApp());
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // Handle the notification when the app is terminated or in the background
  print('Notification received in the background: ${message.notification?.title}');
  // You can show a local notification or update the UI as needed
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return GetMaterialApp(
            initialBinding: AppBindings(),
            theme: AppTheme().appTheme(),
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
        );
      },
    );
  }
}

