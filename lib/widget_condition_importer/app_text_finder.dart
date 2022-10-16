import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_salon/widget_condition_importer/text_finder.dart';
import 'package:flutter/material.dart';

class AppTextFinder implements TextFinder {
  AppTextFinder();

  @override
  StatelessWidget getWidget(String text) {
    return Text('AppTextFinder: $text');
  }
}

TextFinder getTextFinder() => AppTextFinder();
