import 'package:flutter/material.dart';

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
  List<String> imageUrls = [
    'https://flutter.salon/wp-content/uploads/2022/11/IMGP0818-768x508.jpg',
    'https://flutter.salon/wp-content/uploads/2023/03/IMGP5710-768x514.jpg',
    'https://flutter.salon/wp-content/uploads/2023/03/IMGP5591-768x514.jpg',
    'https://flutter.salon/wp-content/uploads/2023/03/IMGP4555-768x514.jpg',
    'https://flutter.salon/wp-content/uploads/2023/02/IMGP8968-768x514.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index) =>
              NetworkImageWithEvent(imageUrls[index])),
    );
  }
}

class NetworkImageWithEvent extends StatelessWidget {
  static int _counter = 0;
  const NetworkImageWithEvent(
    this.url, {
    super.key,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress != null) {
          return const CircularProgressIndicator();
        }
        return child;
      },
      frameBuilder: (
        BuildContext context,
        Widget child,
        int? frame,
        bool wasSynchronouslyLoaded,
      ) {
        if (!wasSynchronouslyLoaded && frame == 0) {
          print('image was loaded');
        }
        print('frameBuilder was called: ${_counter++}');
        return child;
      },
    );
  }
}
