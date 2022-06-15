import 'package:energyone_station/views/stations/widget/rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/station_controller.dart';
import '../../../helpers/date_converter.dart';
import '../../../helpers/dimension.dart';
import '../../../helpers/price_converter.dart';
import '../../../helpers/routes.dart';
import '../../../model/response/product_model.dart';
import '../../../widget/confirm_dialog.dart';
import '../../../widget/snackbar.dart';
import '../../menu/widget/image.dart';
import '../../products/new_product.dart';
import 'available_widget.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final int index;
  final int length;
  final bool inStation;
  final bool isCampaign;
  ProductWidget(
      {required this.product,
      required this.index,
      required this.length,
      this.inStation = false,
      this.isCampaign = false});

  @override
  Widget build(BuildContext context) {
    // BaseUrls _baseUrls = Get.find<SplashController>().configModel.baseUrls;
    bool _desktop = false;
    double _discount;
    String _discountType;
    bool _isAvailable;
    _isAvailable = DateConverter.isAvailable(
            '${product.availableTimeStarts}', '${product.availableTimeEnds}') &&
        DateConverter.isAvailable(
            product.stationOpeningTime, product.stationClosingTime);

    return InkWell(
      onTap: () => {},
      // Get.toNamed(RouteHelper.getProductDetailsRoute(product),
      // arguments: ProductDetailsScreen(product: product)),
      child: Container(
        padding: null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: null,
          boxShadow: null,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: _desktop ? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: CustomImage(
                    image: '/${product.image}',
                    height: _desktop ? 120 : 65,
                    width: _desktop ? 120 : 80,
                    fit: BoxFit.cover,
                  ),
                ),
                _isAvailable
                    ? SizedBox()
                    : NotAvailableWidget(isStation: false),
              ]),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.mulish(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            fontWeight: FontWeight.w500),
                        maxLines: _desktop ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      RatingBar(
                        rating: product.avgRating!,
                        size: _desktop ? 15 : 12,
                        ratingCount: product.ratingCount!,
                      ),
                    ]),
              ),
              IconButton(
                onPressed: () {
                  // if (Get.find<AuthController>().profileModel!.productSection) {
                  Get.toNamed(RouteHelper.getProductRoute(product.id),
                      arguments: AddProductScreen());
                  // } else {
                  //   showCustomSnackBar('this_feature_is_blocked_by_admin'.tr);
                  // }
                },
                icon: const Icon(Icons.edit, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  // if (Get.find<AuthController>().profileModel!.productSection) {
                  Get.dialog(ConfirmationDialog(
                      icon: "assets/warning.png",
                      description:
                          'are_you_sure_want_to_delete_this_product'.tr,
                      onYesPressed: () => {}
                      // Get.find<StationController>()
                      // .deleteProduct(product.id),
                      ));
                  // } else {
                  //   showCustomSnackBar('this_feature_is_blocked_by_admin'.tr);
                  // }
                },
                icon: const Icon(Icons.delete_forever, color: Colors.red),
              ),
            ]),
          )),
          _desktop
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(left: _desktop ? 130 : 90),
                  child: Divider(
                      color: index == length - 1
                          ? Colors.transparent
                          : Theme.of(context).disabledColor),
                ),
        ]),
      ),
    );
  }
}
