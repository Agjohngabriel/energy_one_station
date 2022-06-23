import 'package:energyone_station/helpers/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/dimension.dart';
import '../../helpers/res.dart';
import '../../helpers/routes.dart';
import 'login_view_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final GlobalKey<FormState> formkey = GlobalKey();
  final LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(resizeToAvoidBottomInset: false,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/side.png",
            scale: 3,
          ),
          const SizedBox(height: 20),
          Image.asset("assets/energy_one.png", width: 100),
          const SizedBox(height: 50),

          Text('Sign In'.toUpperCase(),
              style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blue,
                  letterSpacing: 0.4,
                  fontSize: width(context, 0.043))),
          const SizedBox(height: 14),

          Text('only for station managers',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.blue,
                  letterSpacing: 0.7,
                  fontSize: width(context, 0.038))),
          const SizedBox(height: 50),

          Card(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: 392,
                    height: 66,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCtrl,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? "Please Enter a valid Email address"
                            : null;
                      },
                      decoration: InputDecoration(
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        errorStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        filled: true,
                        prefixIcon: const Icon(Icons.email_outlined),
                        fillColor: AppTheme.white,
                        hintText: 'johndoe@station.com',
                        hintStyle: GoogleFonts.mulish(
                          color: AppTheme.blue.withOpacity(0.8),
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 392,
                    height: 66,
                    child: TextFormField(
                      controller: passwordCtrl,
                      validator: (value) {
                        return (value == null || value.isEmpty)
                            ? "Please Enter a password"
                            : null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        errorStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))),
                        filled: true,
                        fillColor: AppTheme.white,
                        hintText: 'Enter Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility_off),
                        suffixIconColor: AppTheme.blue,
                        prefixIconColor: AppTheme.blue,
                        hintStyle: GoogleFonts.mulish(
                          color: AppTheme.blue.withOpacity(0.8),
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          Row(children: [
            Expanded(
              child: ListTile(
                // onTap: () => authController.toggleRememberMe(),
                leading: Checkbox(
                  activeColor: AppTheme.blue,
                  value: true,
                  onChanged: (bool? value) {
                    value = false;
                  },
                  // value: authController.isActiveRememberMe,
                  // onChanged: (bool isChecked) => authController.toggleRememberMe(),
                ),
                title: Text(
                  'Remember me',
                  style: GoogleFonts.mulish(color: AppTheme.grey),
                ),
                contentPadding: EdgeInsets.zero,
                dense: true,
                horizontalTitleGap: 0,
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute()),
              child: Text(
                '${'Forgot password'}?',
                style: GoogleFonts.mulish(color: AppTheme.blue),
              ),
            ),
          ]),
          const SizedBox(height: 50),

          InkWell(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              if (formkey.currentState?.validate() ?? false) {
                await _viewModel.loginUser(
                    emailCtrl.text.trim(), passwordCtrl.text.trim());
              }
              setState(() {
                isLoading = false;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 13, right: 13),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                  color: AppTheme.blue,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                  child: Text(
                isLoading ? "Loading...." : "Sign In",
                style: GoogleFonts.mulish(
                  color: AppTheme.white,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                ),
              )),
            ),
          ),
          // !authController.isLoading ?
          // CustomButton(
          //   buttonText: 'Sign in'.tr,
          //   onPressed: () async => {
          //     print(phoneCtrl.text)
          //     // if (formkey.currentState?.validate() ?? false)
          //     //   {
          //     //     await _viewModel.loginUser(
          //     //         phoneCtrl.text.trim(), passwordCtrl.text.trim())
          //     //   }
          //   }
          //   // _login(authController)
          //   ,
          // )
          // : Center(child: CircularProgressIndicator()),
        ]),
      ),
    );
  }
}
