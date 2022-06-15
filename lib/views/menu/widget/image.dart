import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeholder;
  CustomImage(
      {required this.image,
      this.height,
      this.width,
      required this.fit,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/placeholder.jpg',
      height: height,
      width: width,
      fit: fit,
      image: image,
      imageErrorBuilder: (c, o, s) => Image.asset(
        placeholder != null ? '$placeholder' : 'assets/placeholder.jpg',
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
