import '../views/splashScreen.dart';
import '../widget/snackbar.dart';
import 'authManager.dart';
import 'package:get/get.dart';

class Api {
  AuthManager authManager = Get.put(AuthManager());
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<AuthManager>().logOut();
      Get.offAll(Splash());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
