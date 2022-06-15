import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/apptheme.dart';
import 'custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
  ConfirmationDialog(
      {required this.icon,
      this.title,
      required this.description,
      required this.onYesPressed,
      this.isLogOut = false,
      this.hasCancel = true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(fontSize: 15),
                  ),
                )
              : SizedBox(),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(description,
                style: GoogleFonts.mulish(fontSize: 13),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 15),

          // GetBuilder<OrderController>(builder: (orderController) {
          //   return !orderController.isLoading ?
          Row(children: [
            hasCancel
                ? Expanded(
                    child: TextButton(
                    onPressed: () => isLogOut ? onYesPressed() : Get.back(),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      minimumSize: Size(1170, 40),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: AppTheme.blue),
                      ),
                    ),
                    child: Text(
                      isLogOut ? 'Yes'.tr : 'No'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(fontSize: 14),
                    ),
                  ))
                : SizedBox(),
            SizedBox(width: hasCancel ? 15 : 0),
            Expanded(
                child: CustomButton(
              buttonText: isLogOut
                  ? 'No'
                  : hasCancel
                      ? 'Yes'
                      : 'Ok',
              onPressed: () => isLogOut ? Get.back() : onYesPressed(),
              height: 40,
            )),
          ])
        ]),
      ),
    );
  }
}
