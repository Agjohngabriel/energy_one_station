import 'package:get/get.dart';

import '../model/response/notification_model.dart';
import '../repo/notification_repo.dart';
import '../services/api.dart';
import '../services/api_services.dart';

class NotificationController extends GetxController implements GetxService {
  final ApiServices _apiServices = Get.put(ApiServices());
  final NotificationRepo? notificationRepo;
  NotificationController({this.notificationRepo});

  List<NotificationModel>? _notificationList;
  List<NotificationModel>? get notificationList => _notificationList;

  Future<void> getNotificationList() async {
    Response response = await _apiServices.getNotificationList();
    print(response.statusCode);
    if (response.statusCode == 200) {
      _notificationList = [];
      List<dynamic> _notifications = response.body.reversed.toList();
      for (var notification in _notifications) {
        NotificationModel _notification =
            NotificationModel.fromJson(notification);
        _notification.title = notification['data']['title'];
        _notification.description = notification['data']['description'];
        _notification.image = notification['data']['image'];
        _notificationList?.add(_notification);
      }
    } else {
      Api.checkApi(response);
    }
    update();
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo?.saveSeenNotificationCount(count);
  }

  int? getSeenNotificationCount() {
    return notificationRepo?.getSeenNotificationCount();
  }
}
