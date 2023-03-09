// flutter pub add qr_flutter

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter QR Code Generator'),
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
  String _message = '';
  bool _qrCodeGenerated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    _message = value;
                    if (_qrCodeGenerated) {
                      setState(() {
                        _qrCodeGenerated = false;
                      });
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => setState(() {
                  _qrCodeGenerated = true;
                }),
              ),
            ],
          ),
          (_qrCodeGenerated)
              ? QrImage(
                  embeddedImage: const NetworkImage(
                    'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
                  ),
                  data: _message,
                  gapless: false,
                )
              : const Center(
                  child: Text('QRコード用のテキストを入力して、\n ボタンを押してください'),
                ),
        ],
      ),
    );
  }
}
