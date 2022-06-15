import 'package:get/get.dart';
import 'cache_manager.dart';

class AuthManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void logIn(String? token) async {
    isLogged.value = true;
    await saveToken(token);
  }

  String fetchToken() {
    final token = getToken();
    return token.toString();
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}
