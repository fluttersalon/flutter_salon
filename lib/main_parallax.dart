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
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Flutter Parallax Demo Page'),
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
  final _keyList = List.generate(urls.length, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            setState(() {});

            return false;
          },
          child: ListView.builder(
              itemCount: urls.length,
              itemBuilder: (context, index) {
                final box = _keyList[index].currentContext?.findRenderObject();
                if (box is RenderBox) {
                  print('Image $index: ${box.localToGlobal(Offset.zero).dy}');
                }

                final gap = box is RenderBox
                    ? 2 * box.localToGlobal(Offset.zero).dy / screenHeight - 1
                    : 0.0;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        key: _keyList[index],
                        urls[index],
                        fit: BoxFit.fitWidth,
                        alignment: Alignment(0, gap),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
final urls = [
  '$urlPrefix/01-mount-rushmore.jpg',
  '$urlPrefix/02-singapore.jpg',
  '$urlPrefix/03-machu-picchu.jpg',
  '$urlPrefix/04-vitznau.jpg',
  '$urlPrefix/05-bali.jpg',
  '$urlPrefix/06-mexico-city.jpg',
  '$urlPrefix/07-cairo.jpg',
];
