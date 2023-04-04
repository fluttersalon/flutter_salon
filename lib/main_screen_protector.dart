import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';

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
  bool _noScreenshot = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(_noScreenshot ? 'No Screenshot' : 'Can take screenshot'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_noScreenshot ? Icons.no_photography : Icons.camera_alt),
        onPressed: () {
          setState(() => _noScreenshot = !_noScreenshot);
          if (_noScreenshot) {
            ScreenProtector.preventScreenshotOn();
          } else {
            ScreenProtector.preventScreenshotOff();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }
}
