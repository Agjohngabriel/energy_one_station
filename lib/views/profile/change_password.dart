import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/dimension.dart';
import '../../model/response/profile_model.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/snackbar.dart';

class NewPassScreen extends StatefulWidget {
  final String resetToken;
  final String email;
  final bool fromPasswordChange;
  NewPassScreen(
      {required this.resetToken,
      required this.email,
      required this.fromPasswordChange});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

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
            "Change Password",
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
      body: SafeArea(
          child: Center(
              child: Scrollbar(
                  child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Center(
            child: SizedBox(
                width: 1170,
                child: Column(children: [
                  Text('Enter new password',
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                            spreadRadius: 1,
                            blurRadius: 5)
                      ],
                    ),
                    child: Column(children: [
                      CustomTextField(
                        hintText: 'New password',
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocus,
                        nextFocus: _confirmPasswordFocus,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: "assets/lock.png",
                        isPassword: true,
                        divider: true,
                      ),
                      CustomTextField(
                        hintText: 'Confirm Password'.tr,
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: "assets/lock.png",
                        isPassword: true,
                        onSubmit: (text) =>
                            GetPlatform.isWeb ? _resetPassword() : null,
                      ),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  GetBuilder<AuthController>(builder: (authController) {
                    return !authController.isLoading
                        ? CustomButton(
                            buttonText: 'Done'.tr,
                            onPressed: () => _resetPassword(),
                          )
                        : const Center(child: CircularProgressIndicator());
                  }),
                ]))),
      )))),
    );
  }

  void _resetPassword() {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('Enter password');
    } else if (_password.length < 6) {
      showCustomSnackBar('Password should be atleast 8 characters');
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('Password does not matched');
    } else {
      if (widget.fromPasswordChange) {
        ProfileModel? _user = Get.find<AuthController>().profileModel;
        // Get.find<AuthController>().changePassword(_user, _password);
      } else {
        // Get.find<AuthController>().resetPassword(widget.resetToken, widget.email, _password, _confirmPassword).then((value) {
        //   if (value.isSuccess) {
        //     Get.find<AuthController>().login(widget.email, _password).then((value) async {
        //       Get.offAllNamed(RouteHelper.getInitialRoute());
        //     });
        //   } else {
        //     showCustomSnackBar(value.message);
        //   }
      }
      ;
    }
  }
  // }
}
