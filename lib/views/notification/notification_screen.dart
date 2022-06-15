import 'package:energyone_station/views/notification/widget/noti_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/notification_controller.dart';
import 'package:get/get.dart';

import '../../helpers/apptheme.dart';
import '../../helpers/date_converter.dart';
import '../../helpers/dimension.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getNotificationList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.blue,
        automaticallyImplyLeading: true,
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Notification",
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
              color: AppTheme.notWhite,
              fontSize: 17,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body:
          GetBuilder<NotificationController>(builder: (notificationController) {
        if (notificationController.notificationList != null) {
          notificationController.saveSeenNotificationCount(
              notificationController.notificationList!.length);
        }
        List<DateTime> _dateTimeList = [];
        return notificationController.notificationList != null
            ? notificationController.notificationList!.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      await notificationController.getNotificationList();
                    },
                    child: Scrollbar(
                        child: SingleChildScrollView(
                            child: Center(
                                child: SizedBox(
                                    width: 1170,
                                    child: ListView.builder(
                                      itemCount: notificationController
                                          .notificationList?.length,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        DateTime _originalDateTime =
                                            DateConverter.dateTimeStringToDate(
                                                '${notificationController.notificationList![index].createdAt}');
                                        DateTime _convertedDate = DateTime(
                                            _originalDateTime.year,
                                            _originalDateTime.month,
                                            _originalDateTime.day);
                                        bool _addTitle = false;
                                        if (!_dateTimeList
                                            .contains(_convertedDate)) {
                                          _addTitle = true;
                                          _dateTimeList.add(_convertedDate);
                                        }
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _addTitle
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 10, 10, 0),
                                                      child: Text(DateConverter
                                                          .dateTimeStringToDateTime(
                                                              '${notificationController.notificationList![index].createdAt}')),
                                                    )
                                                  : const SizedBox(),
                                              ListTile(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return NotificationDialog(
                                                            notificationModel:
                                                                notificationController
                                                                        .notificationList![
                                                                    index]);
                                                      });
                                                },
                                                leading: ClipOval(
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                  placeholder:
                                                      'assets/placeholder.jpg',
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
                                                  image:
                                                      '${notificationController.notificationList![index].image}',
                                                  imageErrorBuilder:
                                                      (c, o, s) => Image.asset(
                                                          'assets/placeholder.jpg',
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.cover),
                                                )),
                                                title: Text(
                                                  notificationController
                                                          .notificationList![
                                                              index]
                                                          .title ??
                                                      '',
                                                  style: GoogleFonts.mulish(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_SMALL),
                                                ),
                                                subtitle: Text(
                                                  notificationController
                                                          .notificationList![
                                                              index]
                                                          .description ??
                                                      '',
                                                  style: GoogleFonts.mulish(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_SMALL),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    horizontal: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                child: Divider(
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                              ),
                                            ]);
                                      },
                                    ))))),
                  )
                : Center(child: Text('No notification found'.tr))
            : const Center(
                child: CircularProgressIndicator(
                color: AppTheme.blue,
              ));
      }),
    );
  }
}
