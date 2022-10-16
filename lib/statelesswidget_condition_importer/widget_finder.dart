import 'package:flutter/material.dart';
import 'stub_widget_finder.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'app_widget_finder.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'web_widget_finder.dart';

abstract class WidgetFinder extends StatelessWidget {
  /// factory constructor to return the correct implementation.
  factory WidgetFinder(String text) => getWidgetFinder(text);
}
