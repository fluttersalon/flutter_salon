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
        colorSchemeSeed: Colors.blue,
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
      body: Column(
        children: [
          // 通常のFilledButton
          FilledButton(
            onPressed: () {},
            child: Text(
              'FilledButton(通常)',
            ),
          ),

          // 角丸のFilledButton
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'FilledButton(角丸)',
            ),
          ),

          // アイコン付きのFilledButton
          FilledButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('FilledButton.icon(アイコン付)'),
          ),

          // トーンが薄、余白のあるFilledButton
          FilledButton.tonal(
            onPressed: () {},
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text(
              'FilledButton.tonal(トーン薄、余白)',
            ),
          ),

          // 通常のOutlinedButton(枠線のみのボタン)
          OutlinedButton(
            onPressed: () {},
            child: Text('OutlinedButton(通常)'),
          ),

          // 角丸のOutlinedButton
          OutlinedButton(
            onPressed: () {},
            child: Text('OutlinedButton(角丸)'),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // 丸いFilledButton
          FilledButton(
            onPressed: () {},
            child: Text('丸'),
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
            ),
          ),

          // 丸いOutlinedButton
          OutlinedButton(
            onPressed: () {},
            child: Text('丸'),
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
            ),
          ),

          // FloatingActionButton
          FloatingActionButton(
            onPressed: () {},
            child: Text('FAB'),
          ),

          // TextButton(テキストのボタン。リンク風)
          TextButton(onPressed: () {}, child: Text('TextButton')),

          // IconButton(外枠のないアイコンだけのボタン)
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),

          // CircleAvatar内にIconButton(外枠のあるアイコンのボタン)
          CircleAvatar(
              child: IconButton(onPressed: () {}, icon: Icon(Icons.add))),
        ],
      ),
    );
  }
}
