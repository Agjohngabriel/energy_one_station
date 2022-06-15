import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/dimension.dart';

class CountWidget extends StatelessWidget {
  final String title;
  final int count;
  CountWidget({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Column(children: [
          Text(title,
              style: GoogleFonts.mulish(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: Theme.of(context).cardColor)),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/order.png',
                color: Theme.of(context).cardColor, height: 12, width: 12),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(count.toString(),
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: Theme.of(context).cardColor,
                )),
          ]),
        ]),
      ),
    );
  }
}
