import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/endpoints.dart';

class NotificationRepo {
  final SharedPreferences sharedPreferences;
  NotificationRepo({required this.sharedPreferences});

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(Endpoints.NOTIFICATION_COUNT, count);
  }

  int? getSeenNotificationCount() {
    return sharedPreferences.getInt(Endpoints.NOTIFICATION_COUNT);
  }
}
