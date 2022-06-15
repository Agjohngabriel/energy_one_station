import 'dart:async';

import 'package:energyone_station/views/dasboard/dashboard.dart';
import 'package:energyone_station/views/home/widget/botton_nav.dart';
import 'package:energyone_station/views/home/widget/request_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../controllers/order_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/dimension.dart';
import '../../helpers/notification_helper.dart';
import '../menu/menu_container.dart';
import '../order/order_history_screen.dart';

class Home extends StatefulWidget {
  final int pageIndex;
  Home({required this.pageIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late Timer _timer;
  int? _orderCount;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      Dashboard(),
      OrderHistoryScreen(),
      Container(),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });

    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Get.find<OrderController>().runningOrders != null) {
        _orderCount = Get.find<OrderController>().runningOrders!.length;
      }
      if (kDebugMode) {
        print("onMessage: ${message.data}");
      }
      String? _type = message.notification?.bodyLocKey;
      String? _body = message.notification?.titleLocKey;
      Get.find<OrderController>().getAllOrders();
      Get.find<OrderController>().getCurrentOrders();
      if (_type == 'new_order' || _body == 'New order placed') {
        _orderCount = _orderCount! + 1;
        Get.dialog(NewRequestDialog());
      } else {
        NotificationHelper.showNotification(
            message, flutterLocalNotificationsPlugin, false);
      }
    });
    //
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      await Get.find<OrderController>().getCurrentOrders();
      int _count = Get.find<OrderController>().runningOrders!.length;
      if (_orderCount != null && _orderCount! < _count) {
        Get.dialog(NewRequestDialog());
      } else {
        _orderCount = Get.find<OrderController>().runningOrders!.length;
      }
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _timer?.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        floatingActionButton: !GetPlatform.isMobile
            ? null
            : FloatingActionButton(
                elevation: 5,
                backgroundColor: _pageIndex == 1
                    ? AppTheme.blue
                    : Theme.of(context).cardColor,
                onPressed: () => _setPage(1),
                child: Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: _pageIndex == 1
                      ? Theme.of(context).cardColor
                      : Theme.of(context).disabledColor,
                ),
              ),
        floatingActionButtonLocation: !GetPlatform.isMobile
            ? null
            : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: !GetPlatform.isMobile
            ? const SizedBox()
            : BottomAppBar(
                elevation: 5,
                notchMargin: 5,
                shape: const CircularNotchedRectangle(),
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Row(children: [
                    BottomNavItem(
                        iconData: Icons.home,
                        isSelected: _pageIndex == 0,
                        onTap: () => _setPage(0)),
                    const Expanded(child: SizedBox()),
                    BottomNavItem(
                        iconData: Icons.menu,
                        isSelected: _pageIndex == 2,
                        onTap: () {
                          Get.bottomSheet(MenuScreen(),
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true);
                        }),
                  ]),
                ),
              ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
