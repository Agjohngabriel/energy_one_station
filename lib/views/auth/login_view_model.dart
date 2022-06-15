import 'package:energyone_station/helpers/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth_controller.dart';
import '../../helpers/endpoints.dart';
import '../../model/login_request.dart';
import '../../services/api_services.dart';
import '../../services/authManager.dart';

class LoginViewModel extends GetxController {
  late final ApiServices _apiServices;
  late final AuthManager _authManager;
  late final SharedPreferences sharedPreferences;

  @override
  Future<void> onInit() async {
    super.onInit();
    _apiServices = Get.put(ApiServices());
    _authManager = Get.find();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> loginUser(String email, String password) async {
    print(email);
    print(password);
    final response = await _apiServices
        .fetchLogin(LoginRequestModel(email: email, password: password));
    print(response);
    if (response != null) {
      _authManager.logIn(response.token);
      sharedPreferences.setString(
          Endpoints.ZONE_TOPIC, response.zone_wise_topic!);
      await Get.find<AuthController>().getProfile();
    } else {
      Get.defaultDialog(
          middleText: 'Invalid login details, Try Again',
          textConfirm: 'Ok',
          confirmTextColor: Colors.white,
          buttonColor: AppTheme.blue,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
