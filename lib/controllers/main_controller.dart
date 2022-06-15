import 'package:get/get.dart';

import '../views/dasboard/dashboard.dart';
import '../views/menu/menu_container.dart';
import '../views/order/order_history_screen.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
  int Index = 0;
  void changeTabIndex(int index) {
    Index = index;
    update();
  }

  void setTabIndex() {
    Index = 1;
    update();
  }

  final pages = [
    Dashboard(),
    OrderHistoryScreen(),
    Get.bottomSheet(MenuScreen(),
        backgroundColor: Colors.transparent, isScrollControlled: true),
  ];
}
