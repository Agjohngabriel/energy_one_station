import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/endpoints.dart';
import '../model/body/status_body.dart';
import '../services/authManager.dart';

class OrderRepo extends GetConnect implements GetxService {
  final AuthManager _authmanager = Get.find();
  final SharedPreferences? sharedPreferences;
  OrderRepo({this.sharedPreferences});

  Future<Response> getAllOrders() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.ALL_ORDERS_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> getCurrentOrders() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.CURRENT_ORDERS_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> getCompletedOrders() async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.COMPLETED_ORDERS_URI,
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> updateOrderStatus(UpdateStatusBody updateStatusBody) async {
    updateStatusBody.token = _authmanager.fetchToken();
    return await post(Endpoints.BASE_URL + Endpoints.UPDATE_ORDER_STATUS_URI,
        updateStatusBody.toJson());
  }

  Future<Response> getOrderDetails(int orderID) async {
    String token = _authmanager.fetchToken();
    return await get(
        Endpoints.BASE_URL + Endpoints.ORDER_DETAILS_URI + '?order_id=$orderID',
        headers: {'Authorization': 'Bearer $token'});
  }
}
