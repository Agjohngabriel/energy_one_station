import 'package:energyone_station/helpers/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/date_converter.dart';
import '../../../helpers/dimension.dart';
import '../../../helpers/routes.dart';
import '../../../model/response/order_model.dart';
import '../../order/order_detail_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  final bool hasDivider;
  final bool isRunning;
  final bool showStatus;
  OrderWidget(
      {required this.orderModel,
      required this.hasDivider,
      required this.isRunning,
      this.showStatus = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouteHelper.getOrderDetailsRoute(orderModel.id),
          arguments: OrderDetailsScreen(
            orderModel: orderModel,
            isRunningOrder: isRunning,
          )),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('${'Order Id'}: #${orderModel.id}',
                      style: GoogleFonts.mulish()),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(children: [
                    Text(
                      DateConverter.dateTimeStringToDateTime(
                          '${orderModel.createdAt}'),
                      style: GoogleFonts.mulish(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).disabledColor),
                    ),
                    Container(
                      height: 10,
                      width: 1,
                      color: Theme.of(context).disabledColor,
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    ),
                  ]),
                ])),
            showStatus
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL,
                        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: AppTheme.blue,
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      orderModel.orderStatus!.toUpperCase(),
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).cardColor),
                    ),
                  )
                : Text(
                    '${orderModel.detailsCount} ${orderModel.detailsCount! < 2 ? 'item'.tr : 'items'.tr}',
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: Theme.of(context).disabledColor),
                  ),
            showStatus
                ? const SizedBox()
                : const Icon(Icons.keyboard_arrow_right,
                    size: 30, color: AppTheme.blue),
          ]),
        ),
        hasDivider
            ? Divider(color: Theme.of(context).disabledColor)
            : const SizedBox(),
      ]),
    );
  }
}
