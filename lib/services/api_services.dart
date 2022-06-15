import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/endpoints.dart';
import '../model/login_request.dart';
import '../model/response/login_response_model.dart';
import '../model/response/profile_model.dart';
import 'authManager.dart';
import 'package:http/http.dart' as http;

class ApiServices extends GetConnect {
  late final SharedPreferences sharedPreferences;

  final AuthManager _authmanager = Get.find();
  Future<Response> fetchUser() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.PROFILE_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response =
        await post(Endpoints.BASE_URL + Endpoints.LOGIN_URI, model.toJson());
    print(response.statusCode);
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Response> updateActiveStatus() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.UPDATE_STATION_STATUS_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> getAllOrders() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.ALL_ORDERS_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> getNotificationList() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.NOTIFICATION_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  // Future<Response> getLatestOrders() async {
  //   String token = _authmanager.fetchToken();
  //   return await get(Endpoints.BASE_URL + Endpoints.CURRENT_ORDERS_URI,
  //       headers: {'Authorization': 'Bearer $token'});
  // }

  // Future<void> setIgnoreList(List<IgnoreModel> ignoreList) async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   List<String> _stringList = [];
  //   ignoreList.forEach((ignore) {
  //     _stringList.add(jsonEncode(ignore.toJson()));
  //   });
  //   sharedPreferences.setStringList(Endpoints.IGNORE_LIST, _stringList);
  // }
  //
  // List<IgnoreModel> getIgnoreList() {
  //   List<IgnoreModel> _ignoreList = [];
  //   List<String> _stringList =
  //       sharedPreferences.getStringList(Endpoints.IGNORE_LIST) ?? [];
  //   _stringList.forEach((ignore) {
  //     _ignoreList.add(IgnoreModel.fromJson(jsonDecode(ignore)));
  //   });
  //   return _ignoreList;
  // }

  // Future<Response> acceptOrder(int orderID) async {
  //   var body = {'order_id': orderID};
  //   String token = _authmanager.fetchToken();
  //   return await put(Endpoints.BASE_URL + Endpoints.A, body,
  //       headers: {'Authorization': 'Bearer $token'});
  // }

  // Future<Response> getOrderDetails(int orderID) async {
  //   String token = _authmanager.fetchToken();
  //   return await get(
  //       Endpoints.BASE_URL + Endpoints.orderDetails + '?order_id=$orderID',
  //       headers: {'Authorization': 'Bearer $token'});
  // }
  //
  // Future<Response> viewDetails(int orderID) async {
  //   String token = _authmanager.fetchToken();
  //   return await get(
  //       Endpoints.BASE_URL + Endpoints.viewDetails + '?order_id=$orderID',
  //       headers: {'Authorization': 'Bearer $token'});
  // }

  // Future<Response> getCurrentOrders() async {
  //   String token = _authmanager.fetchToken();
  //   return await get(Endpoints.BASE_URL + Endpoints.currentOrders,
  //       headers: {'Authorization': 'Bearer $token'});
  // }

  // Future<Response> updateOrderStatus(UpdateStatusBody updateStatusBody) async {
  //   String token = _authmanager.fetchToken();
  //   return await put(Endpoints.BASE_URL + Endpoints.updateOrderStatus,
  //       updateStatusBody.toJson(),
  //       headers: {'Authorization': 'Bearer $token'});
  // }
  //
  // Future<http.StreamedResponse> UPDATE_PROFILE_URI(
  //     ProfileModel userInfoModel, XFile data, String token) async {
  //   http.MultipartRequest request = http.MultipartRequest('POST',
  //       Uri.parse('${Endpoints.BASE_URL}${Endpoints.UPDATE_PROFILE_URI}'));
  //   request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
  //   if (GetPlatform.isMobile && data != null) {
  //     File _file = File(data.path);
  //     request.files.add(http.MultipartFile(
  //         'image', _file.readAsBytes().asStream(), _file.lengthSync(),
  //         filename: _file.path.split('/').last));
  //   } else if (GetPlatform.isWeb && data != null) {
  //     Uint8List _list = await data.readAsBytes();
  //     var part = http.MultipartFile(
  //         'image', data.readAsBytes().asStream(), _list.length,
  //         filename: basename(data.path),
  //         contentType: MediaType('image', 'jpg'));
  //     request.files.add(part);
  //   }
  //   Map<String, String> _fields = {};
  //   _fields.addAll(<String, String>{
  //     '_method': 'put',
  //     'firstname': userInfoModel.firstName,
  //     'lastname': userInfoModel.lastName,
  //     'email': '${userInfoModel.email}',
  //     'token': '${_authmanager.getToken()}'
  //   });
  //   request.fields.addAll(_fields);
  //   http.StreamedResponse response = await request.send();
  //   return response;
  // }

  // Future<Response> resetPassword(String resetToken, String phone,
  //     String password, String confirmPassword) async {
  //   String token = _authmanager.fetchToken();
  //   return await put(Endpoints.BASE_URL + Endpoints.UPDATE_PROFILE_URI, {
  //     'phone': phone,
  //     'reset_token': resetToken,
  //     'password': password,
  //     'confirm_password': confirmPassword,
  //   }, headers: {
  //     'Authorization': 'Bearer $token'
  //   });
  // }

  Future<Response> updateToken() async {
    String? _deviceToken = '';
    if (GetPlatform.isIOS) {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    } else {
      _deviceToken = await _saveDeviceToken();
    }
    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(Endpoints.TOPIC);
      if (kDebugMode) {
        print(
            '--------------${sharedPreferences.getString(Endpoints.ZONE_TOPIC)}');
      }
      FirebaseMessaging.instance
          .subscribeToTopic(sharedPreferences.getString(Endpoints.ZONE_TOPIC)!);
    }
    String token = _authmanager.fetchToken();
    return await put(Endpoints.BASE_URL + Endpoints.TOKEN_URI, {
      'fcm_token': _deviceToken,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
  }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '';
    if (!GetPlatform.isWeb) {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }
    if (_deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- ' + _deviceToken);
      }
    }
    return _deviceToken;
  }

  Future<Response> toggleStationClosedStatus() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.UPDATE_STATION_STATUS_URI,
        headers: {'Authorization': 'Bearer $token'});
  }
}
