import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_salon/statelesswidget_condition_importer/widget_finder.dart';
import 'package:flutter/material.dart';

class WebWidgetFinder extends StatelessWidget implements WidgetFinder {
  WebWidgetFinder(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text('WebWidgetFinder: $text');
  }
}

WidgetFinder getWidgetFinder(String text) => WebWidgetFinder(text);
