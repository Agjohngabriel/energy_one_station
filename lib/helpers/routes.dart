import 'dart:convert';

import 'package:get/get.dart';

import '../model/response/order_model.dart';
import '../model/response/product_model.dart';
import '../model/response/profile_model.dart';
import '../views/notification/notification_screen.dart';
import '../views/order/order_detail_screen.dart';
import '../views/products/new_product.dart';
import '../views/profile/change_password.dart';
import '../views/profile/profile_screen.dart';
import '../views/profile/setting.dart';
import '../views/splashScreen.dart';
import '../views/stations/stations_screen.dart';
import '../views/support/support.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String verification = '/verification';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String orderDetails = '/order-details';
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';
  static const String notification = '/notification';
  static const String bankInfo = '/bank-info';
  static const String wallet = '/wallet';
  static const String withdrawHistory = '/withdraw-history';
  static const String station = '/station';
  static const String product = '/product';
  static const String categories = '/categories';
  static const String subCategories = '/sub-categories';
  static const String stationSettings = '/station-settings';
  static const String productDetails = '/product-details';
  static const String pos = '/pos';
  static const String deliveryMan = '/delivery-man';
  static const String addDeliveryMan = '/add-delivery-man';
  static const String deliveryManDetails = '/delivery-man-details';
  static const String supportRoute = '/support';

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getVerificationRoute(String email) =>
      '$verification?email=$email';
  static String getMainRoute(String page) => '$main?page=$page';
  static String getForgotPassRoute() => forgotPassword;
  static String getResetPasswordRoute(
          String phone, String token, String page) =>
      '$resetPassword?phone=$phone&token=$token&page=$page';
  static String getOrderDetailsRoute(int orderID) =>
      '$orderDetails?id=$orderID';
  static String getProfileRoute() => profile;
  static String getUpdateProfileRoute() => updateProfile;
  static String getNotificationRoute() => notification;
  static String getBankInfoRoute() => bankInfo;
  static String getWalletRoute() => wallet;
  static String getWithdrawHistoryRoute() => withdrawHistory;
  static String getStationRoute() => station;
  static String getProductRoute(int id) => '$product?id=$id';
  static String getCategoriesRoute() => categories;
  static String getSupportRoute() => supportRoute;
  // static String getSubCategoriesRoute(CategoryModel categoryModel) {
  //   List<int> _encoded = utf8.encode(jsonEncode(categoryModel.toJson()));
  //   String _data = base64Encode(_encoded);
  //   return '$subCategories?data=$_data';
  // }
  static String getStationSettingsRoute(Station station) {
    List<int> _encoded = utf8.encode(jsonEncode(station.toJson()));
    String _data = base64Encode(_encoded);
    return '$stationSettings?data=$_data';
  }
  // static String getProductDetailsRoute(Product product) {
  //   List<int> _encoded = utf8.encode(jsonEncode(product.toJson()));
  //   String _data = base64Encode(_encoded);
  //   return '$productDetails?data=$_data';
  // }

  static List<GetPage> routes = [
    // GetPage(name: initial, page: () => DashboardScreen(pageIndex: 0)),
    GetPage(name: splash, page: () => Splash()),
    // GetPage(name: signIn, page: () => SignInScreen()),
    // GetPage(
    //     name: verification,
    //     page: () => VerificationScreen(email: Get.parameters['email'])),
    // GetPage(
    //     name: main,
    //     page: () => DashboardScreen(
    //           pageIndex: Get.parameters['page'] == 'home'
    //               ? 0
    //               : Get.parameters['page'] == 'favourite'
    //                   ? 1
    //                   : Get.parameters['page'] == 'cart'
    //                       ? 2
    //                       : Get.parameters['page'] == 'order'
    //                           ? 3
    //                           : Get.parameters['page'] == 'menu'
    //                               ? 4
    //                               : 0,
    //         )),
    // GetPage(name: forgotPassword, page: () => ForgetPassScreen()),
    GetPage(
        name: resetPassword,
        page: () => NewPassScreen(
              resetToken: '${Get.parameters['token']}',
              email: '${Get.parameters['phone']}',
              fromPasswordChange: Get.parameters['page'] == 'password-change',
            )),
    GetPage(
        name: orderDetails,
        page: () {
          return Get.arguments ??
              OrderDetailsScreen(
                orderModel:
                    OrderModel(id: int.parse('${Get.parameters['id']}')),
                isRunningOrder: false,
              );
        }),
    GetPage(name: profile, page: () => ProfileScreen()),
    // GetPage(name: updateProfile, page: () => UpdateProfileScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(name: station, page: () => StationScreen()),
    GetPage(name: supportRoute, page: () => SupportScreen()),
    GetPage(
        name: product,
        page: () {
          return Get.arguments ??
              AddProductScreen(
                  // product: Get.parameters['id'] == '0'
                  //     ? null
                  //     : Product(id: int.parse('${Get.parameters['id']}')),
                  );
        }),
    GetPage(
        name: stationSettings,
        page: () {
          List<int> _decode = base64Decode('${Get.parameters['data']}');
          Station _data = Station.fromJson(jsonDecode(utf8.decode(_decode)));
          return StationSettingsScreen(station: _data);
        }),
    // GetPage(
    //     name: productDetails,
    //     page: () {
    //       List<int> _decode = base64Decode(Get.parameters['data']);
    //       Product _data = Product.fromJson(jsonDecode(utf8.decode(_decode)));
    //       return ProductDetailsScreen(product: _data);
    //     }),
  ];
}
