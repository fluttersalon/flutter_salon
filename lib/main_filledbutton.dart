import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        //primarySwatch: Colors.red,
        colorSchemeSeed: Colors.red,
        brightness: _brightness,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        changeBrightness: changeBrightness,
      ),
    );
  }

  void changeBrightness() {
    setState(() {
      _brightness =
          _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.title, required this.changeBrightness})
      : super(key: key);

  final String title;

  final void Function() changeBrightness;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _radioValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilledButton(onPressed: () {}, child: Text('FilledButton')),
              FilledButton.tonal(
                onPressed: () {},
                child: Text('FilledButton.tonal'),
              ),
              FilledButton(
                  onPressed: null, child: Text('FilledButton disabled')),
              FilledButton.tonal(
                onPressed: null,
                child: Text('FilledButton.tonal disabled'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('FilledButton.icon'),
              ),
              FilledButton.tonalIcon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('FilledButton.tonalIcon'),
              ),
              FilledButton(
                  onPressed: () {},
                  child: Text(
                    'LargeFont',
                    style: TextStyle(fontSize: 48),
                  )),
              Divider(),
              ElevatedButton(onPressed: () {}, child: Text('ElevatedButton')),
              OutlinedButton(onPressed: () {}, child: Text('OutlinedButton')),
              TextButton(onPressed: () {}, child: Text('TextButton')),
              Text('Just text (Not Button)'),
              Checkbox(value: true, onChanged: (_) {}),
              TextField(),
              Switch(value: true, onChanged: (_) {}),
              DropdownMenu<int>(
                  dropdownMenuEntries: [1, 2, 3]
                      .map((e) =>
                          DropdownMenuEntry(value: e, label: e.toString()))
                      .toList()),
              Radio(
                value: true,
                groupValue: _radioValue,
                onChanged: (_) {},
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.dark_mode), onPressed: widget.changeBrightness),
    );
  }
}
