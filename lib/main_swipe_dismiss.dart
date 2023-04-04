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
      home: const MyHomePage(title: 'Flutter Demo: swipe to dismiss'),
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
  static const urlPrefix =
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) {
          var url = urls[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Dismissible(
              key: ValueKey(url),
              onDismissed: (direction) {
                setState(() {
                  urls.removeAt(index);
                });
              },
              direction: DismissDirection.startToEnd,
              confirmDismiss: (direction) async {
                var result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: const Text('Would you delete it?'),
                    actions: <Widget>[
                      SimpleDialogOption(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      SimpleDialogOption(
                        child: const Text('Delete'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ],
                  ),
                );
                return Future.value(result);
              },
              background: Container(
                color: Colors.black26,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
              dismissThresholds: const {DismissDirection.startToEnd: 0.4},
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    url,
                    fit: BoxFit.fitWidth,
                  )),
            ),
          );
        },
      ),
    );
  }
}
