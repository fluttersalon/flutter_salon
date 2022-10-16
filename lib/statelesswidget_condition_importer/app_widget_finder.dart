import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_salon/statelesswidget_condition_importer/widget_finder.dart';
import 'package:flutter/material.dart';

class AppWidgetFinder extends StatelessWidget implements WidgetFinder {
  const AppWidgetFinder(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text('AppWidgetFinder: $text');
  }
}

WidgetFinder getWidgetFinder(String text) => AppWidgetFinder(text);
