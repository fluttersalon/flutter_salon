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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyElevatedButton(
              onPressed: () {},
              message: 'Sign in',
            ),
            MyElevatedButton(
              onPressed: null,
              message: 'Sign in',
            )
          ],
        ),
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final String message;
  final double height = 67.0;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.message,
    this.gradient =
        const LinearGradient(colors: [Color(0xfffec230), Color(0xfff9a825)]),
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(height / 2.0);
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
