import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/dimension.dart';
import '../../../widget/custom_button.dart';

class NewRequestDialog extends StatefulWidget {
  @override
  State<NewRequestDialog> createState() => _NewRequestDialogState();
}

class _NewRequestDialogState extends State<NewRequestDialog> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _startAlarm();
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
  }

  void _startAlarm() async {
    AudioCache _audio = AudioCache();
    _audio.play('notification.mp3');
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _audio.play('notification.mp3');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      //insetPadding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset("assets/notification.jpg",
              height: 60, color: Theme.of(context).primaryColor),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              'New order placed',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),
          CustomButton(
            height: 40,
            buttonText: 'Ok',
            onPressed: () {
              _timer.cancel();
              Get.back();
            },
          ),
        ]),
      ),
    );
  }
}
