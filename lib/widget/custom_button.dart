import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/apptheme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final IconData? icon;
  CustomButton(
      {this.onPressed,
      this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : AppTheme.blue,
      minimumSize: Size(width ?? 1170, height ?? 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );

    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: TextButton(
        onPressed: onPressed,
        style: _flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null
              ? Icon(
                  icon,
                  color:
                      transparent ? AppTheme.blue : Theme.of(context).cardColor,
                  size: 20,
                )
              : SizedBox(),
          SizedBox(width: icon != null ? 6 : 0),
          Text(buttonText ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(fontSize: 17, color: AppTheme.white)),
        ]),
      ),
    );
  }
}
