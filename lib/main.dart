import 'package:energyone_station/helpers/endpoints.dart';
import 'package:energyone_station/helpers/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'helpers/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  await GetStorage.init();

  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //
  // int? _orderID;
  try {
    //   if (GetPlatform.isMobile) {
    //     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //         await flutterLocalNotificationsPlugin
    //             .getNotificationAppLaunchDetails();
    //     if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //       _orderID = notificationAppLaunchDetails?.payload != null
    //           ? int.parse('${notificationAppLaunchDetails?.payload}')
    //           : null;
    //     }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    // }
  } catch (e) {}
  //

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final int? orderID;
  // MyApp({required this.orderID});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      title: Endpoints.APP_NAME,
      navigatorKey: Get.key,
      initialRoute: RouteHelper.getSplashRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
