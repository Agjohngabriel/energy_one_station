import 'package:energyone_station/views/profile/widget/bg.dart';
import 'package:energyone_station/views/profile/widget/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/dimension.dart';
import '../../helpers/routes.dart';
import '../../widget/switch_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return authController.profileModel == null
            ? const Center(
                child: CircularProgressIndicator(
                color: AppTheme.blue,
              ))
            : ProfileBgWidget(
                backButton: true,
                circularImage: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).cardColor),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: ClipOval(
                      child: FadeInImage.assetNetwork(
                    placeholder: "assets/placeholder.jpg",
                    image:
                        '/${authController.profileModel != null ? authController.profileModel!.station!.logo : ''}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                        "assets/placeholder.jpg",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover),
                  )),
                ),
                mainWidget: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                        child: Container(
                      width: 1170,
                      color: Theme.of(context).cardColor,
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Column(children: [
                        Text(
                          '${authController.profileModel?.fName}',
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.FONT_SIZE_LARGE),
                        ),
                        const SizedBox(height: 30),
                        Row(children: [
                          ProfileCard(
                              title: 'Since joining',
                              data:
                                  '${authController.profileModel?.memberSinceDays} ${'Days'}'),
                          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          ProfileCard(
                              title: 'Total order'.tr,
                              data: '${authController.profileModel?.orderCount}'
                                  .toString()),
                        ]),
                        const SizedBox(height: 30),
                        SwitchButton(
                            icon: Icons.dark_mode,
                            title: 'Dark Mode',
                            isButtonActive: false,
                            onTap: () {
                              // Get.find<ThemeController>().toggleTheme();
                            }),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        SwitchButton(
                          icon: Icons.notifications,
                          title: 'Notification',
                          isButtonActive: true,
                          onTap: () {
                            // authController.setNotificationActive(
                            //     !authController.notification);
                          },
                        ),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        SwitchButton(
                            icon: Icons.lock,
                            title: 'Change Password'.tr,
                            onTap: () {
                              Get.toNamed(RouteHelper.getResetPasswordRoute(
                                  '', '', 'password-change'));
                            }),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        SwitchButton(
                            icon: Icons.edit,
                            title: 'Edit Profile'.tr,
                            onTap: () {
                              Get.toNamed(RouteHelper.getUpdateProfileRoute());
                            }),
                      ]),
                    ))),
              );
      }),
    );
  }
}
