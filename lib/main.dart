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
  var _checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: ExpansionTile(
                title: Text('親アイテム'),
                children: <Widget>[
                  ListTile(title: Text('子アイテム1')),
                  ListTile(title: Text('子アイテム2')),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: Text('タイトル'),
                backgroundColor: Colors.yellow,
                leading: Icon(Icons.folder_open),
                trailing: Checkbox(
                  value: _checked,
                  onChanged: (bool? value) {
                    setState(() {
                      _checked = value ?? false;
                    });
                  },
                ),
                children: [
                  ListTile(
                    title: Text('子要素1'),
                  ),
                  ListTile(
                    title: Text('子要素2'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
