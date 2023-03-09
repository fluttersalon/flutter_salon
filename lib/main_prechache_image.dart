import 'package:flutter/material.dart';

const imageUrl = 'https://docs.flutter.dev/assets/images/dash/Dashatars.png';
const precacheImageInMain = true;

void main() async {
  if (precacheImageInMain) {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    binding.deferFirstFrame();
    binding.addPostFrameCallback((_) {
      final Element? context = binding.renderViewElement;
      if (context != null) {
        final image = const NetworkImage(imageUrl)
          ..resolve(const ImageConfiguration())
              .addListener(ImageStreamListener((_, __) {
            binding.allowFirstFrame();
          }));
        precacheImage(image, context);
      }
    });
  }
  runApp(const MyApp('precacheImageInMain: $precacheImageInMain'));
}

class MyApp extends StatelessWidget {
  const MyApp(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    if (!precacheImageInMain) {
      precacheImage(const NetworkImage(imageUrl), context);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
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
          children: [
            const Text('Hello Dash!'),
            Image.network(imageUrl),
          ],
        ),
      ),
    );
  }
}
