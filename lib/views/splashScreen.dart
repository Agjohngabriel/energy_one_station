import 'package:energyone_station/helpers/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/authManager.dart';
import 'onboard.dart';

class Splash extends StatelessWidget {
  final AuthManager _authManager = Get.put(AuthManager());

  Future<void> initializeSettings() async {
    _authManager.checkLoginStatus();

    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waitingView();
          } else {
            if (snapshot.hasError) {
              return errorView(snapshot);
            } else {
              return const Onboard();
            }
          }
        });
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: AppTheme.blue,
          ),
        ),
        Text("Loading....")
      ],
    )));
  }
}
