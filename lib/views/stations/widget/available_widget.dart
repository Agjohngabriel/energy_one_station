import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/dimension.dart';

class NotAvailableWidget extends StatelessWidget {
  final double fontSize;
  final bool isStation;
  NotAvailableWidget({this.fontSize = 8, this.isStation = false});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: Colors.black.withOpacity(0.6)),
        child: Text(
          isStation ? 'Closed now' : 'Not available now break',
          textAlign: TextAlign.center,
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
