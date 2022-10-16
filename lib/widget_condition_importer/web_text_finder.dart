import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_salon/widget_condition_importer/text_finder.dart';
import 'package:flutter/material.dart';

class WebTextFinder implements TextFinder {
  WebTextFinder();

  @override
  StatelessWidget getWidget(String text) {
    return Text('WebTextFinder: $text');
  }
}

TextFinder getTextFinder() => WebTextFinder();
