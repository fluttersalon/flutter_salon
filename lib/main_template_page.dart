import 'dart:async';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  late final template = Template(
      key: ObjectKey(DateTime.now().toString()),
      title: widget.title,
      builder: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            OutlinedButton(
              onPressed: _incrementCounter,
              child: Text('押す'),
            ),
          ],
        );
      }));

  late final template2 = Template2(
      key: ObjectKey(DateTime.now().toString()),
      title: widget.title,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          OutlinedButton(
            onPressed: _incrementCounter,
            child: Text('押す'),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    print('main was built');

    return Template3.builder(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          OutlinedButton(
            onPressed: _incrementCounter,
            child: Text('押す'),
          ),
        ],
      ),
    );
  }
}

class Template extends StatelessWidget {
  const Template({super.key, required this.title, required this.builder});

  final String title;
  final Builder builder;

  @override
  Widget build(BuildContext context) {
    print('Template was built');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: builder.build(context),
      ),
    );
  }
}

class Template2 extends StatelessWidget {
  const Template2({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('Template was built');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: child,
      ),
    );
  }
}

class Template3 extends StatelessWidget {
  Template3({super.key, required this.title});

  final String title;

  late Widget _child;

  static final _template = Template3(
    title: 'test',
  );

  static Widget builder(BuildContext context, Widget child) {
    _template._child = child;
    return Builder(builder: (context) => _template.build(context));
  }

  @override
  Widget build(BuildContext context) {
    print('Template was built');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: _child,
      ),
    );
  }
}
