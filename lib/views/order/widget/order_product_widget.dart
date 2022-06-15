import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../helpers/dimension.dart';
import '../../../helpers/price_converter.dart';
import '../../../model/response/order_detail.dart';
import '../../../model/response/order_model.dart';
import '../../menu/widget/image.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderModel order;
  final OrderDetailsModel orderDetails;
  OrderProductWidget({required this.order, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          child: CustomImage(
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            image: '${orderDetails.productDetails.image}',
          ),
        ),
        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(
                '${orderDetails.productDetails.name}',
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.FONT_SIZE_SMALL),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
              Text('${'quantity'.tr}:',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              Text(
                orderDetails.quantity.toString(),
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.FONT_SIZE_SMALL),
              ),
            ]),
            const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(
              PriceConverter.convertPrice(orderDetails.price),
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ),
      ]),
      const Divider(height: Dimensions.PADDING_SIZE_LARGE),
      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
    ]);
  }
}
