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
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      width: 1,
    ),
  );

  final _formKey = GlobalKey<FormState>();
  var _label = '検証';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return '必須です';
                }

                return null;
              },
              decoration: InputDecoration(
                border: borderStyle,
                focusedBorder: borderStyle.copyWith(
                  borderSide: const BorderSide(width: 2),
                ),
                enabledBorder: borderStyle,
                errorBorder: borderStyle.copyWith(
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                disabledBorder: borderStyle.copyWith(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                labelText: '電話番号',
                hintText: '09012345678',
              ),
            ),
            FilledButton(
                onPressed: () {
                  setState(() {
                    _label =
                        _formKey.currentState!.validate() ? '検証成功!' : '検証失敗!';
                  });
                },
                child: Text(_label)),
          ],
        ),
      ),
    );
  }
}
