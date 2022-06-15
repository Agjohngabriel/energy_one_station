import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/authManager.dart';
import 'auth/login.dart';
import 'home/homePage.dart';

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthManager _authmanager = Get.find();
    return Obx(() {
      return _authmanager.isLogged.value
          ? Home(
              pageIndex: 0,
            )
          : Login();
    });
  }
}
