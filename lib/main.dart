import 'package:flutter/material.dart';
import 'package:flutter_salon/statelesswidget_condition_importer/widget_finder.dart';
import 'package:flutter_salon/widget_condition_importer/text_finder.dart';
import 'package:flutter_salon/data_importer/data_importer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(DataImporter().getValue('test')),
            TextFinder().getWidget('from main'),
            WidgetFinder('test'),
            Image(
                image: NetworkImage(
                    'https://avatars.githubusercontent.com/u/13707135')),
            Image.network('https://avatars.githubusercontent.com/u/13707135'),
          ],
        ),
      ),
    );
  }
}
