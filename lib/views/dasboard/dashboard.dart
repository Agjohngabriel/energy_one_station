import 'package:energyone_station/helpers/apptheme.dart';
import 'package:energyone_station/views/dasboard/widget/order_button.dart';
import 'package:energyone_station/views/dasboard/widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/order_controller.dart';
import '../../helpers/dimension.dart';
import '../../helpers/price_converter.dart';
import '../../helpers/routes.dart';
import '../../model/response/order_model.dart';
import '../../widget/confirm_dialog.dart';
import '../../widget/order_shimmer.dart';
import '../menu/menu_container.dart';
import '../order/widget/count_widget.dart';

class Dashboard extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  NotificationController notificationController =
      Get.put(NotificationController());
  OrderController orderController = Get.put(OrderController());

  bool showStatus = true;
  bool hasDivider = true;
  Future<void> _loadData() async {
    await Get.find<AuthController>().getProfile();
    await Get.find<OrderController>().getCurrentOrders();
    await Get.find<NotificationController>().getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          leading: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Image.asset('assets/side.png', height: 30, width: 30),
          ),
          titleSpacing: 0,
          elevation: 0,
          /*title: Text(AppConstants.APP_NAME, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.mulish(
          color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_DEFAULT,
        )),*/
          title: Image.asset('assets/energy_one.png', width: 120),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppTheme.blue,
                size: 25,
              ),
              // GetBuilder<NotificationController>(
              //     builder: (notificationController) {
              //   bool _hasNewNotification = false;
              //   if (notificationController.notificationList != null) {
              //     _hasNewNotification =
              //         notificationController.notificationList?.length !=
              //             notificationController.getSeenNotificationCount();
              //   }
              //   return Stack(children: [
              //     const Icon(Icons.menu,
              //         size: 25, color: AppTheme.blue),
              //     _hasNewNotification
              //         ? Positioned(
              //             top: 0,
              //             right: 0,
              //             child: Container(
              //               height: 10,
              //               width: 10,
              //               decoration: BoxDecoration(
              //                 color: AppTheme.blue,
              //                 shape: BoxShape.circle,
              //                 border: Border.all(
              //                     width: 1, color: Theme.of(context).cardColor),
              //               ),
              //             ))
              //         : const SizedBox(),
              //   ]);
              // }),
              onPressed: () {
                Get.bottomSheet(MenuScreen(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true);
              },
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await _loadData();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(children: [
                GetBuilder<AuthController>(builder: (authController) {
                  return Column(children: [
                    Container(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[Get.isDarkMode ? 700 : 200]!,
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              "Station is ${authController.profileModel!.station!.active ? "Online" : "Offline"}",
                              style: GoogleFonts.mulish(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            !authController.isLoading
                                ? authController.profileModel != null
                                    ? Switch(
                                        value: authController
                                            .profileModel!.station!.active,
                                        activeColor: Colors.green[100],
                                        inactiveThumbColor: Colors.red[100],
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (bool isActive) {
                                          Get.dialog(ConfirmationDialog(
                                            title: !isActive
                                                ? "Going Offline?"
                                                : "Going Online?",
                                            icon: 'assets/warning.png',
                                            description: !isActive
                                                ? 'Your station will longer receive orders'
                                                : 'Your station will be available to receive orders',
                                            onYesPressed: () {
                                              Get.back();
                                              authController
                                                  .toggleStationClosedStatus();
                                            },
                                          ));
                                        },
                                      )
                                    : Shimmer(
                                        duration: const Duration(seconds: 2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey[300]),
                                          height: 30,
                                          width: 50,
                                        ))
                                : const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppTheme.blue,
                                        strokeWidth: 3.0,
                                      ),
                                    ),
                                  )
                          ]),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.blue,
                      ),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/wallet.png',
                                scale: 3,
                              ),
                              const SizedBox(width: 18),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Today'.tr,
                                      style: GoogleFonts.mulish(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.6,
                                          color:
                                              AppTheme.white.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      authController.profileModel != null
                                          ? PriceConverter.convertPrice(
                                              authController
                                                  .profileModel!.todaysEarning!)
                                          : '0',
                                      style: GoogleFonts.mulish(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.white),
                                    ),
                                  ]),
                            ]),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'This week'.tr,
                                        style: GoogleFonts.mulish(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.6,
                                            color: AppTheme.white
                                                .withOpacity(0.8)),
                                      ),
                                      Divider(
                                          thickness: 1,
                                          color:
                                              AppTheme.white.withOpacity(0.8)),
                                      Text(
                                        authController.profileModel != null
                                            ? PriceConverter.convertPrice(
                                                authController.profileModel!
                                                    .thisWeekEarning!)
                                            : '0',
                                        style: GoogleFonts.mulish(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/order.png',
                                                color:
                                                    Theme.of(context).cardColor,
                                                height: 12,
                                                width: 12),
                                            const SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            Text(
                                                "${authController.profileModel!.thisWeekOrderCount!}",
                                                style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                )),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Text(
                                              'orders'.tr,
                                              style: GoogleFonts.mulish(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 0.6,
                                                  color: AppTheme.white
                                                      .withOpacity(0.8)),
                                            ),
                                          ]),
                                    ]),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'This month'.tr,
                                      style: GoogleFonts.mulish(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.6,
                                          color:
                                              AppTheme.white.withOpacity(0.8)),
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: AppTheme.white.withOpacity(0.8)),
                                    Text(
                                      authController.profileModel != null
                                          ? PriceConverter.convertPrice(
                                              authController.profileModel!
                                                  .thisWeekEarning!)
                                          : '0',
                                      style: GoogleFonts.mulish(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/order.png',
                                              color:
                                                  Theme.of(context).cardColor,
                                              height: 12,
                                              width: 12),
                                          const SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          Text(
                                              "${authController.profileModel!.thisMonthOrderCount!}",
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE,
                                                color:
                                                    Theme.of(context).cardColor,
                                              )),
                                          SizedBox(
                                            width: 9,
                                          ),
                                          Text(
                                            'orders'.tr,
                                            style: GoogleFonts.mulish(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 0.6,
                                                color: AppTheme.white
                                                    .withOpacity(0.8)),
                                          ),
                                        ]),
                                  ]),
                            )),
                          ],
                        ),
                      ]),
                    ),
                  ]);
                }),
                const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                GetBuilder<OrderController>(builder: (orderController) {
                  List<OrderModel> _orderList = [];
                  if (orderController.runningOrders != null) {
                    _orderList = orderController
                        .runningOrders![orderController.orderIndex].orderList;
                  }

                  return Column(children: [
                    orderController.runningOrders != null
                        ? Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).disabledColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: orderController.runningOrders?.length,
                              itemBuilder: (context, index) {
                                return OrderButton(
                                  title: orderController
                                      .runningOrders![index].status,
                                  index: index,
                                  orderController: orderController,
                                  fromHistory: false,
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
                    orderController.runningOrders != null
                        ? _orderList.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _orderList.length,
                                itemBuilder: (context, index) {
                                  return OrderWidget(
                                      orderModel: _orderList[index],
                                      hasDivider:
                                          index != _orderList.length - 1,
                                      isRunning: true);
                                },
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(child: Text('No order found')),
                              )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return OrderShimmer(
                                  isEnabled:
                                      orderController.runningOrders == null);
                            },
                          ),
                  ]);
                }),
              ]),
            )));
  }
}
