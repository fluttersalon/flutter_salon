import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'outer_server_image.dart';

class OuterServerImageWeb extends StatelessWidget implements OuterServerImage {
  const OuterServerImageWeb(this.imageUrl);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement()
        ..src = imageUrl
        ..style.width = '100%'
        ..style.height = '100%',
    );
    return HtmlElementView(
      viewType: imageUrl,
    );
  }
}

OuterServerImage getOuterServerImage(String urlImage,
        {double? width, double? height}) =>
    OuterServerImageWeb(
      urlImage,
    );
