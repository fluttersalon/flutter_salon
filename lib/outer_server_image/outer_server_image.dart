import 'package:flutter/material.dart';
import 'outer_server_image_stub.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'outer_server_image_app.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'outer_server_image_web.dart';

abstract class OuterServerImage extends StatelessWidget {
  factory OuterServerImage(String urlImage, {double? width, double? height}) =>
      getOuterServerImage(urlImage, width: width, height: height);
}
