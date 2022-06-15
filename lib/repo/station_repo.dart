import 'package:energyone_station/services/authManager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/endpoints.dart';
import '../model/response/product_model.dart';

class StationRepo extends GetConnect implements GetxService {
  final AuthManager _authmanager = Get.find();

  Future<Response> getProductList(String offset) async {
    String token = _authmanager.fetchToken();
    return await get(Endpoints.BASE_URL + Endpoints.PRODUCT_LIST_URI,
        headers: {'Authorization': 'Bearer $token'});
    // return await apiClient.getData('${AppConstants.PRODUCT_LIST_URI}?offset=$offset&limit=10');
  }

  //
  // Future<Response> updateRestaurant(
  //     Restaurant restaurant, XFile logo, XFile cover, String token) async {
  //   http.MultipartRequest request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           '${AppConstants.BASE_URL}${AppConstants.RESTAURANT_UPDATE_URI}'));
  //   request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
  //   if (GetPlatform.isMobile && logo != null) {
  //     File _file = File(logo.path);
  //     request.files.add(http.MultipartFile(
  //         'logo', _file.readAsBytes().asStream(), _file.lengthSync(),
  //         filename: _file.path.split('/').last));
  //   }
  //   if (GetPlatform.isMobile && cover != null) {
  //     File _file = File(cover.path);
  //     request.files.add(http.MultipartFile(
  //         'cover_photo', _file.readAsBytes().asStream(), _file.lengthSync(),
  //         filename: _file.path.split('/').last));
  //   }
  //   Map<String, String> _fields = Map();
  //   _fields.addAll(<String, String>{
  //     '_method': 'put',
  //     'name': restaurant.name,
  //     'contact_number': restaurant.phone,
  //     'schedule_order': restaurant.scheduleOrder ? '1' : '0',
  //     'opening_time': restaurant.availableTimeStarts,
  //     'closeing_time': restaurant.availableTimeEnds,
  //     'off_day': restaurant.offDay,
  //     'address': restaurant.address,
  //     'minimum_order': restaurant.minimumOrder.toString(),
  //     'delivery': restaurant.delivery ? '1' : '0',
  //     'take_away': restaurant.takeAway ? '1' : '0',
  //     'gst_status': restaurant.gstStatus ? '1' : '0',
  //     'gst': restaurant.gstCode,
  //     'delivery_charge': restaurant.deliveryCharge.toString()
  //   });
  //   request.fields.addAll(_fields);
  //   print(request.fields);
  //   http.StreamedResponse response = await request.send();
  //   return Response(
  //       statusCode: response.statusCode, statusText: response.reasonPhrase);
  // }
  //
  Future<Response> addProduct(Product product) async {
    final token = _authmanager.fetchToken();

    Map<String, String> _fields = {};
    _fields.addAll(<String, String>{
      'name': product.name,
      'price': product.price.toString(),
      'available_time_starts': '${product.availableTimeStarts}',
      'available_time_ends': '${product.availableTimeEnds}',
      'description': product.description,
    });

    print(_fields);

    return await post(Endpoints.BASE_URL + Endpoints.ADD_PRODUCT_URI, _fields);
  }

  // Future<Response> deleteProduct(int productID) async {
  //   return await apiClient
  //       .deleteData('${AppConstants.DELETE_PRODUCT_URI}?id=$productID');
  // }
  //
  // Future<Response> getRestaurantReviewList(int restaurantID) async {
  //   return await apiClient.getData(
  //       '${AppConstants.RESTAURANT_REVIEW_URI}?restaurant_id=$restaurantID');
  // }
  //
  // Future<Response> getProductReviewList(int productID) async {
  //   return await apiClient
  //       .getData('${AppConstants.PRODUCT_REVIEW_URI}/$productID');
  // }
  //
  // Future<Response> updateProductStatus(int productID, int status) async {
  //   return await apiClient.getData(
  //       '${AppConstants.UPDATE_PRODUCT_STATUS_URI}?id=$productID&status=$status');
  // }
}
