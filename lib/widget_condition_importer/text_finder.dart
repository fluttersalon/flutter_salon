import 'package:flutter/material.dart';
import 'stub_text_finder.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'app_text_finder.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'web_text_finder.dart';

abstract class TextFinder {
  // some generic methods to be exposed.
  StatelessWidget getWidget(String text);

  /// factory constructor to return the correct implementation.
  factory TextFinder() => getTextFinder();
}
