import 'package:energyone_station/views/order/widget/order_product_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/order_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/date_converter.dart';
import '../../helpers/dimension.dart';
import '../../helpers/price_converter.dart';
import '../../model/response/order_detail.dart';
import '../../model/response/order_model.dart';
import '../../widget/confirm_dialog.dart';
import '../../widget/slider_button.dart';
import '../../widget/snackbar.dart';
import '../menu/widget/image.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel orderModel;
  bool isRunningOrder = true;
  OrderDetailsScreen({required this.orderModel, required this.isRunningOrder});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      Get.find<OrderController>().getCurrentOrders();
      String _type = message.data['type'];
      if (isRunningOrder && _type == 'order_status') {
        Get.back();
      }
    });

    Get.find<OrderController>().getOrderDetails(orderModel.id);
    // bool _restConfModel = Get.find<SplashController>().configModel.orderConfirmationModel != 'deliveryman';
    bool _showSlider = orderModel.orderStatus == 'pending' ||
        orderModel.orderStatus == 'confirmed' ||
        orderModel.orderStatus == 'accepted' ||
        orderModel.orderStatus == 'handover';
    bool _showBottomView =
        _showSlider || orderModel.orderStatus == 'picked_up' || isRunningOrder;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.blue,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Order Detail",
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
        double? _deliveryCharge = 0;
        double _itemsPrice = 0;
        OrderModel _order = orderModel;
        if (orderController.orderDetailsModel != null) {
          for (OrderDetailsModel orderDetails
              in orderController.orderDetailsModel!) {
            print(orderDetails.price);
            print(orderDetails.quantity);
            _itemsPrice =
                _itemsPrice + (orderDetails.price * orderDetails.quantity);
          }
        }

        return orderController.orderDetailsModel != null
            ? Column(children: [
                Expanded(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Center(
                      child: SizedBox(
                          width: 1170,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('${'Order Id'}:',
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                      width:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text(_order.id.toString(),
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                      width:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  const Expanded(child: SizedBox()),
                                  const Icon(Icons.watch_later, size: 17),
                                  const SizedBox(
                                      width:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text(
                                    DateConverter.dateTimeStringToDateTime(
                                        '${_order.createdAt}'),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ]),
                                const SizedBox(
                                    height: Dimensions.PADDING_SIZE_SMALL),

                                _order.scheduled == 1
                                    ? Row(children: [
                                        Text('${'Scheduled at'}:',
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w400)),
                                        const SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Text(
                                            DateConverter
                                                .dateTimeStringToDateTime(
                                                    '${_order.scheduleAt}'),
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w500)),
                                      ])
                                    : const SizedBox(),
                                SizedBox(
                                    height: _order.scheduled == 1
                                        ? Dimensions.PADDING_SIZE_SMALL
                                        : 0),

                                Row(children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL,
                                        vertical: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    decoration: BoxDecoration(
                                      color: AppTheme.blue,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_SMALL),
                                    ),
                                    child: Text(
                                      _order.paymentMethod == 'cash_on_delivery'
                                          ? 'Pending'.tr
                                          : 'Paid'.tr,
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL),
                                    ),
                                  ),
                                ]),
                                const Divider(
                                    height: Dimensions.PADDING_SIZE_LARGE),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Row(children: [
                                    Text('${'item'.tr}:',
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Text(
                                      _order.detailsCount.toString(),
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.blue),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Container(
                                        height: 7,
                                        width: 7,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle)),
                                    const SizedBox(
                                        width: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Text(
                                      _order.orderStatus == 'delivered'
                                          ? '${'delivered_at'.tr} ${DateConverter.dateTimeStringToDateTime('${_order.delivered}')}'
                                          : '${_order.orderStatus}',
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ]),
                                ),
                                const Divider(
                                    height: Dimensions.PADDING_SIZE_LARGE),
                                const SizedBox(
                                    height: Dimensions.PADDING_SIZE_SMALL),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      orderController.orderDetailsModel!.length,
                                  itemBuilder: (context, index) {
                                    return OrderProductWidget(
                                        order: _order,
                                        orderDetails: orderController
                                            .orderDetailsModel![index]);
                                  },
                                ),

                                (_order.orderNote != null &&
                                        _order.orderNote!.isNotEmpty)
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            Text('Additional note',
                                                style: GoogleFonts.mulish(
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            const SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            Container(
                                              width: 1170,
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_SMALL),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_SMALL),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                              ),
                                              child: Text(
                                                '${_order.orderNote}',
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                              ),
                                            ),
                                            const SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_LARGE),
                                          ])
                                    : const SizedBox(),

                                Text('Customer Details',
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Row(children: [
                                  ClipOval(
                                      child: CustomImage(
                                    image: '${_order.customer?.image}',
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  )),
                                  const SizedBox(
                                      width: Dimensions.PADDING_SIZE_SMALL),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                          _order.deliveryAddress
                                              .contactPersonName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                        Text(
                                          _order.deliveryAddress.address,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                      ])),
                                  (_order.orderStatus == 'pending' ||
                                          _order.orderStatus == 'confirmed' ||
                                          _order.orderStatus == 'accepted')
                                      ? TextButton.icon(
                                          onPressed: () async {
                                            String url =
                                                'https://www.google.com/maps/dir/?api=1&destination=${_order.deliveryAddress.latitude}'
                                                ',${_order.deliveryAddress.longitude}&mode=d';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              showCustomSnackBar(
                                                  'Unable to launch google map'
                                                      .tr);
                                            }
                                          },
                                          icon: const Icon(Icons.directions),
                                          label: Text('Direction'.tr),
                                        )
                                      : const SizedBox(),
                                ]),
                                const SizedBox(
                                    height: Dimensions.PADDING_SIZE_LARGE),

                                // Total
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Item Price'.tr,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                          PriceConverter.convertPrice(
                                              _itemsPrice),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400)),
                                    ]),
                                const SizedBox(height: 10),

                                Divider(
                                    thickness: 1,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.5)),

                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Subtotal'.tr,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w500)),
                                      Text(PriceConverter.convertPrice(3000),
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w500)),
                                    ]),
                                const SizedBox(height: 10),

                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Discount'.tr,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                          '(-) ${PriceConverter.convertPrice(1000)}',
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400)),
                                    ]),
                                const SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Delivery fee'.tr,
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                          '(+) ${PriceConverter.convertPrice(600)}',
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w400)),
                                    ]),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.PADDING_SIZE_SMALL),
                                  child: Divider(
                                      thickness: 1,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5)),
                                ),

                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Amount'.tr,
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE,
                                            color: AppTheme.blue,
                                          )),
                                      Text(
                                        PriceConverter.convertPrice(6000),
                                        style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE,
                                            color: AppTheme.blue),
                                      ),
                                    ]),
                              ]))),
                ))),
                _showBottomView
                    ? (orderModel.orderStatus == 'picked_up')
                        ? Container(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              border: Border.all(width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Text('food_is_on_the_way'.tr,
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w500)),
                          )
                        : _showSlider
                            ? SliderButton(
                                action: () {
                                  if (orderModel.orderStatus == 'pending') {
                                    Get.dialog(
                                        ConfirmationDialog(
                                          icon: "assets/warning.png",
                                          title: 'Are you sure',
                                          description:
                                              'You want to confirm this order',
                                          onYesPressed: () {
                                            orderController
                                                .updateOrderStatus(
                                                    orderModel.id, 'confirmed',
                                                    back: true)
                                                .then((success) {
                                              if (success) {
                                                Get.find<AuthController>()
                                                    .getProfile();
                                                Get.find<OrderController>()
                                                    .getCurrentOrders();
                                              }
                                            });
                                          },
                                        ),
                                        barrierDismissible: false);
                                  } else if (orderModel.orderStatus ==
                                      'processing') {
                                    Get.find<OrderController>()
                                        .updateOrderStatus(
                                            orderModel.id, 'handover')
                                        .then((success) {
                                      if (success) {
                                        Get.find<AuthController>().getProfile();
                                        Get.find<OrderController>()
                                            .getCurrentOrders();
                                      }
                                    });
                                  } else if (orderModel.orderStatus ==
                                          'confirmed' ||
                                      (orderModel.orderStatus == 'accepted')) {
                                    Get.find<OrderController>()
                                        .updateOrderStatus(
                                            orderModel.id, 'processing')
                                        .then((success) {
                                      if (success) {
                                        Get.find<AuthController>().getProfile();
                                        Get.find<OrderController>()
                                            .getCurrentOrders();
                                      }
                                    });
                                  }
                                  // else if (orderModel.orderStatus ==
                                  //         'handover' &&
                                  //     orderModel.orderType == 'take_away') {
                                  //   if (Get.find<SplashController>()
                                  //           .configModel
                                  //           .orderDeliveryVerification ||
                                  //       orderModel.paymentMethod ==
                                  //           'cash_on_delivery') {
                                  //     Get.bottomSheet(
                                  //         VerifyDeliverySheet(
                                  //           orderID: orderModel.id,
                                  //           verify: Get.find<SplashController>()
                                  //               .configModel
                                  //               .orderDeliveryVerification,
                                  //           orderAmount: orderModel.orderAmount,
                                  //           cod: orderModel.paymentMethod ==
                                  //               'cash_on_delivery',
                                  //         ),
                                  //         isScrollControlled: true);
                                  //   } else {
                                  //     Get.find<OrderController>()
                                  //         .updateOrderStatus(
                                  //             orderModel.id, 'delivered')
                                  //         .then((success) {
                                  //       if (success) {
                                  //         Get.find<AuthController>()
                                  //             .getProfile();
                                  //         Get.find<OrderController>()
                                  //             .getCurrentOrders();
                                  //       }
                                  //     });
                                  //   }
                                  // }
                                },
                                label: Text(
                                  (orderModel.orderStatus == 'pending')
                                      ? 'Swipe to confirm order'.tr
                                      : (orderModel.orderStatus == 'accepted')
                                          ? 'Swipe to confirm pick up'.tr
                                          : (orderModel.orderStatus ==
                                                  'confirmed')
                                              ? 'swipe_if_ready_for_handover'.tr
                                              : 'cool',
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: AppTheme.blue),
                                ),
                                dismissThresholds: 0.5,
                                dismissible: false,
                                shimmer: true,
                                width: 1170,
                                height: 60,
                                buttonSize: 50,
                                radius: 10,
                                icon: const Center(
                                    child: Icon(Icons.double_arrow_sharp,
                                        color: Colors.white, size: 20.0)),
                                boxShadow: const BoxShadow(blurRadius: 0),
                                buttonColor: AppTheme.blue,
                                backgroundColor: const Color(0xffF4F7FC),
                                baseColor: AppTheme.blue,
                              )
                            : const SizedBox()
                    : const SizedBox(),
              ])
            : const Center(
                child: CircularProgressIndicator(
                color: AppTheme.blue,
              ));
      }),
    );
  }
}
