import 'package:flutter/material.dart';
import 'outer_server_image.dart';

class OuterServerImageApp extends StatelessWidget implements OuterServerImage {
  const OuterServerImageApp(
    this.imageUrl, {
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, width: width, height: height);
  }
}

OuterServerImage getOuterServerImage(String urlImage,
        {double? width, double? height}) =>
    OuterServerImageApp(
      urlImage,
      width: width,
      height: height,
    );
