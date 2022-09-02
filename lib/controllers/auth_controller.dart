import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/response/profile_model.dart';
import '../services/api.dart';
import '../services/api_services.dart';

import '../widget/snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final ApiServices _apiServices = Get.put(ApiServices());
  ProfileModel? _profileModel;
  bool _isLoading = false;
  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;

  ProfileModel? get profileModel => _profileModel;
  bool get isLoading => _isLoading;
  //
  // Future<ResponseModel> login(String phone, String password) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await .login(phone, password);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     .saveUserToken(
  //         response.body['token'], response.body['zone_wise_topic']);
  //     await _apiServices.updateToken();
  //     responseModel = ResponseModel(true, 'successful');
  //   } else {
  //     responseModel = ResponseModel(false, '${response.statusText}');
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  Future<void> getProfile() async {
    Response response = await _apiServices.fetchUser();
    if (kDebugMode) {
      print('profile' '${response.statusCode}');
    }
    if (response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);
    } else {
      Api.checkApi(response);
    }
    update();
  }

  Future<bool> updateActiveStatus() async {
    Response response = await _apiServices.updateActiveStatus();
    bool _isSuccess;
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
      _isSuccess = true;
    } else {
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  void initData() {
    _pickedFile = null;
  }

  // Future<bool> updateUserInfo(
  //     ProfileModel updateUserModel, String token) async {
  //   _isLoading = true;
  //   update();
  //   http.StreamedResponse response = await _apiServices.UPDATE_PROFILE_URI(
  //       updateUserModel, _pickedFile!, token);
  //   _isLoading = false;
  //   bool _isSuccess;
  //   print(response.stream.bytesToString());
  //   if (response.statusCode == 200) {
  //     Map map = jsonDecode(await response.stream.bytesToString());
  //     String message = map["message"];
  //     _profileModel = updateUserModel;
  //     showCustomSnackBar(message, isError: false);
  //     _isSuccess = true;
  //   } else {
  //     Api.checkApi(Response(
  //         statusCode: response.statusCode,
  //         statusText: '${response.statusCode} ${response.reasonPhrase}'));
  //     _isSuccess = false;
  //   }
  //   update();
  //   return _isSuccess;
  // }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  // Future<bool> changePassword(
  //     ProfileModel updatedUserModel, String password) async {
  //   _isLoading = true;
  //   update();
  //   bool _isSuccess;
  //   Response response =
  //       await _apiServices.changePassword(updatedUserModel, password);
  //   _isLoading = false;
  //   if (response.statusCode == 200) {
  //     String message = response.body["message"];
  //     showCustomSnackBar(message, isError: false);
  //     _isSuccess = true;
  //   } else {
  //     Api.checkApi(response);
  //     _isSuccess = false;
  //   }
  //   update();
  //   return _isSuccess;
  // }

  // Future<ResponseModel> resetPassword(String resetToken, String phone,
  //     String password, String confirmPassword) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await _apiServices.resetPassword(
  //       resetToken, phone, password, confirmPassword);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, '${response.statusText}');
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  Future<void> updateToken() async {
    await _apiServices.updateToken();
  }

  Future<void> toggleStationClosedStatus() async {
    _isLoading = true;
    update();
    Response response = await _apiServices.toggleStationClosedStatus();
    if (response.statusCode == 200) {
      getProfile();
    } else {
      Api.checkApi(response);
    }
    _isLoading = false;
    update();
  }
}
