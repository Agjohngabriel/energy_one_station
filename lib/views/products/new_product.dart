import 'dart:io';

import 'package:energyone_station/controllers/station_controller.dart';
import 'package:energyone_station/views/products/widget/text_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/dimension.dart';
import '../../model/response/product_model.dart';
import '../../widget/custom_button.dart';
import '../../widget/snackbar.dart';

class AddProductScreen extends StatefulWidget {
  // late final Product product;
  // AddProductScreen({required this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController _c = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _priceNode = FocusNode();
  final FocusNode _discountNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  // late bool _update;
  late Product _product;

  @override
  void initState() {
    super.initState();

    // _product = widget.product;
    // _update = widget.product != null;
    // Get.find<StationController>().getAttributeList(widget.product);
    // if (_update) {
    //   _nameController.text = _product.name;
    //   _priceController.text = _product.price.toString();
    //   _discountController.text = _product.discount.toString();
    //   _descriptionController.text = _product.description;
    // } else {
    //   _product = Product();
    //   Get.find<StationController>().pickImage(false, true);
    //   _product.availableTimeStarts =
    //       Get.find<AuthController>().profileModel!.availableTimeStarts;
    //   _product.availableTimeEnds =
    //       Get.find<AuthController>().profileModel!.availableTimeEnds;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.blue,
        automaticallyImplyLeading: true,
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Add Product",
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
      body: GetBuilder<StationController>(builder: (restController) {
        return
            // return restController.attributeList != null
            //     ?
            Column(children: [
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MyTextField(
                hintText: 'Product Name',
                controller: _nameController,
                capitalization: TextCapitalization.words,
                focusNode: _nameNode,
                nextFocus: _priceNode,
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              MyTextField(
                hintText: 'Price',
                controller: _priceController,
                focusNode: _priceNode,
                nextFocus: _discountNode,
                isAmount: true,
                amountIcon: true,
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              MyTextField(
                hintText: 'Description',
                controller: _descriptionController,
                focusNode: _descriptionNode,
                capitalization: TextCapitalization.sentences,
                maxLines: 5,
                inputAction: TextInputAction.newline,
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            ]),
          )),
          !restController.isLoading
              ? CustomButton(
                  buttonText: 'Submit',
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  height: 50,
                  onPressed: () {
                    String _name = _nameController.text.trim();
                    String _price = _priceController.text.trim();
                    // String _discount = _discountController.text.trim();
                    String _description = _descriptionController.text.trim();
                    // bool _haveBlankVariant = false;
                    // bool _blankVariantPrice = false;
                    // for (AttributeModel attr
                    //     in restController.attributeList) {
                    //   if (attr.active && attr.variants.length == 0) {
                    //     _haveBlankVariant = true;
                    //     break;
                    //   }
                    // }
                    // for (VariantTypeModel variantType
                    //     in restController.variantTypeList) {
                    //   if (variantType.controller.text.isEmpty) {
                    //     _blankVariantPrice = true;
                    //     break;
                    //   }
                    // }
                    if (_name.isEmpty) {
                      showCustomSnackBar('Enter Product Name');
                    } else if (_price.isEmpty) {
                      showCustomSnackBar('Enter product price');
                      // } else if (_discount.isEmpty) {
                      //   showCustomSnackBar('enter_food_discount'.tr);
                      // } else if (restController.categoryIndex == 0) {
                      //   showCustomSnackBar('select_a_category'.tr);
                      // } else if (_haveBlankVariant) {
                      //   showCustomSnackBar(
                      //       'add_at_least_one_variant_for_every_attribute'
                      //           .tr);
                      // } else if (_blankVariantPrice) {
                      //   showCustomSnackBar(
                      //       'enter_price_for_every_variant'.tr);
                      // } else if (!_update &&
                      //     restController.pickedLogo == null) {
                      //   showCustomSnackBar('upload_food_image'.tr);
                    } else {
                      _product.name = _name;
                      _product.price = double.parse(_price);
                      //   _product.discount = double.parse(_discount);
                      //   _product.discountType =
                      //       restController.discountTypeIndex == 0
                      //           ? 'percent'
                      //           : 'amount';
                      //   _product.categoryIds = [];
                      //   _product.categoryIds.add(CategoryIds(
                      //       id: restController
                      //           .categoryList[
                      //               restController.categoryIndex - 1]
                      //           .id
                      //           .toString()));
                      //   if (restController.subCategoryIndex != 0) {
                      //     _product.categoryIds.add(CategoryIds(
                      //         id: restController
                      //             .subCategoryList[
                      //                 restController.subCategoryIndex - 1]
                      //             .id
                      //             .toString()));
                      //   }
                      _product.description = _description;
                      //   _product.addOns = [];
                      //   restController.selectedAddons.forEach((index) {
                      //     _product.addOns.add(
                      //         Get.find<AddonController>().addonList[index]);
                      //    });
                      restController.addProduct(_product);
                    }
                  },
                )
              : Center(child: CircularProgressIndicator()),
        ]);
        // : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
