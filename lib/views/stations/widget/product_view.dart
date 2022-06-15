import 'package:energyone_station/views/stations/widget/product_shimmer.dart';
import 'package:energyone_station/views/stations/widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/station_controller.dart';
import '../../../helpers/dimension.dart';

class ProductView extends StatelessWidget {
  final ScrollController scrollController;
  ProductView({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    Get.find<StationController>().setOffset(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          Get.find<StationController>().productList != null &&
          !Get.find<StationController>().isLoading) {
        int pageSize = (Get.find<StationController>().pageSize / 10).ceil();
        if (Get.find<StationController>().offset < pageSize) {
          Get.find<StationController>()
              .setOffset(Get.find<StationController>().offset + 1);
          print('end of the page');
          Get.find<StationController>().showBottomLoader();
          Get.find<StationController>()
              .getProductList(Get.find<StationController>().offset.toString());
        }
      }
    });
    return GetBuilder<StationController>(builder: (restController) {
      return Column(children: [
        restController.productList != null
            ? restController.productList!.isNotEmpty
                ? GridView.builder(
                    key: UniqueKey(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                      mainAxisSpacing: 0.01,
                      childAspectRatio: 4,
                      crossAxisCount: 1,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: restController.productList?.length,
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        product: restController.productList![index],
                        index: index,
                        length: restController.productList!.length,
                        isCampaign: false,
                        inStation: true,
                      );
                    },
                  )
                : Center(child: Text('No Product Available'.tr))
            : GridView.builder(
                key: UniqueKey(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                  mainAxisSpacing: 0.01,
                  childAspectRatio: 4,
                  crossAxisCount: 1,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                itemBuilder: (context, index) {
                  return ProductShimmer(
                    isEnabled: restController.productList == null,
                    hasDivider: index != 19,
                  );
                },
              ),
        restController.isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor)),
              ))
            : const SizedBox(),
      ]);
    });
  }
}
