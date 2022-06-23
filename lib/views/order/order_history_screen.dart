import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/order_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/dimension.dart';
import '../dasboard/widget/order_button.dart';
import '../dasboard/widget/order_widget.dart';
import 'widget/count_widget.dart';

class OrderHistoryScreen extends StatelessWidget {
  // final AuthManager _authManager = Get.put(AuthManager());
  bool showStatus = true;
  bool hasDivider = true;
  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getCompletedOrders();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.blue,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Order History",
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
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Column(children: [
            GetBuilder<AuthController>(builder: (authController) {
              return authController.profileModel != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppTheme.blue,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      ),
                      child: Row(children: [
                        CountWidget(
                            title: 'Today',
                            count:
                                authController.profileModel!.todaysOrderCount!),
                        CountWidget(
                            title: 'This week',
                            count: authController
                                .profileModel!.thisWeekOrderCount!),
                        CountWidget(
                            title: 'This month',
                            count: authController
                                .profileModel!.thisMonthOrderCount!),
                      ]),
                    )
                  : const SizedBox();
            }),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            orderController.orderList != null
                ? Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).disabledColor, width: 1),
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orderController.statusList.length,
                      itemBuilder: (context, index) {
                        return OrderButton(
                          title: orderController.statusList[index].toUpperCase(),
                          index: index,
                          orderController: orderController,
                          fromHistory: true,
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            SizedBox(
                height: orderController.orderList != null
                    ? Dimensions.PADDING_SIZE_SMALL
                    : 0),
            Expanded(
              child: orderController.orderList != null
                  ? orderController.orderList!.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async =>
                              await orderController.getCompletedOrders(),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: orderController.orderList?.length,
                            itemBuilder: (context, index) {
                              return OrderWidget(
                                orderModel: orderController.orderList![index],
                                hasDivider: index !=
                                    orderController.orderList!.length - 1,
                                isRunning: false,
                                showStatus: orderController.historyIndex == 0,
                              );
                            },
                          ),
                        )
                      : Center(child: Text('No order found'.tr))
                  : const Center(
                      child: CircularProgressIndicator(
                      color: AppTheme.blue,
                    )),
            ),
          ]),
        );
      }),
    );
  }
}
