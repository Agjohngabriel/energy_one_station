import 'package:energyone_station/helpers/apptheme.dart';
import 'package:energyone_station/services/authManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../../../helpers/dimension.dart';
import '../../../helpers/routes.dart';
import '../../../model/response/menu_model.dart';
import '../../../widget/confirm_dialog.dart';
import '../../../widget/snackbar.dart';
import 'image.dart';

class MenuButton extends StatelessWidget {
  final MenuModel menu;
  final bool isProfile;
  final bool isLogout;
  MenuButton(
      {required this.menu, required this.isProfile, required this.isLogout});

  @override
  Widget build(BuildContext context) {
    double _size = (context.width / 4) - Dimensions.PADDING_SIZE_DEFAULT;

    return InkWell(
      onTap: () {
        if (menu.isBlocked) {
          showCustomSnackBar('This feature is blocked by admin'.tr);
        } else {
          if (isLogout) {
            Get.back();
            if (isLogout) {
              Get.dialog(
                  ConfirmationDialog(
                      icon: 'assets/warning.png',
                      description: 'Are you sure you want to logout',
                      isLogOut: true,
                      onYesPressed: () {
                        Get.back();
                        Get.find<AuthManager>().logOut();
                        Get.offAllNamed(RouteHelper.getSignInRoute());
                      }),
                  useSafeArea: false);
            } else {
              Get.find<AuthManager>().logOut();
              Get.toNamed(RouteHelper.getSignInRoute());
            }
          } else {
            Get.offNamed(menu.route);
          }
        }
      },
      child: Column(children: [
        Container(
          height: _size - (_size * 0.2),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: isLogout
                ? Get.find<AuthManager>().isLogged()
                    ? Colors.red
                    : Colors.green
                : AppTheme.blue,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
          ),
          alignment: Alignment.center,
          child: isProfile
              ? ProfileImageWidget(size: _size)
              : Image.asset(menu.icon,
                  width: _size, height: _size, color: Colors.white),
        ),
        const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text(menu.title,
            style: GoogleFonts.mulish(
                fontSize: Dimensions.FONT_SIZE_SMALL,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
      ]),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final double size;
  ProfileImageWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.white)),
        child: ClipOval(
          child: CustomImage(
            image:
                // '${Get.find<SplashController>().configModel.baseUrls.vendorImageUrl}'
                '/${(authController.profileModel != null && Get.find<AuthManager>().isLogged()) ? authController.profileModel!.station!.logo ?? '' : ''}',
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}
