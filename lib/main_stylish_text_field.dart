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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            // TextField左端の虫眼鏡のアイコン(飾り)
            prefixIcon: const Icon(Icons.search),

            // TextField右端のソート方法選択のアイコン
            suffixIcon: IconButton(
              icon: Icon(
                Icons.sort,
                size: 32,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {},
            ),

            // 空白時(初期状態)でTextFiledに入力されている文字
            hintText: 'ヒント',
            hintStyle: Theme.of(context).textTheme.bodyMedium,

            // 角丸
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(128),
            ),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
