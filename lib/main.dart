import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '押すと震えるボタン'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _keyShakeWidget = GlobalKey<ShakeWidgetState>();
  final _keyFastShakeWidget = GlobalKey<ShakeWidgetState>();
  final _keySlowShakeWidget = GlobalKey<ShakeWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ShakeWidget(
              key: _keyShakeWidget,
              child: FilledButton(
                onPressed: () => _keyShakeWidget.currentState?.shake(),
                child: const Text('震える'),
              ),
            ),
            ShakeWidget(
              key: _keyFastShakeWidget,
              count: 5,
              offset: 10,
              duration: const Duration(milliseconds: 300),
              child: FilledButton(
                onPressed: () => _keyFastShakeWidget.currentState?.shake(),
                child: const Text('激しく震える'),
              ),
            ),
            ShakeWidget(
              key: _keySlowShakeWidget,
              count: 2,
              offset: 50,
              duration: const Duration(milliseconds: 3000),
              child: FilledButton(
                onPressed: () => _keySlowShakeWidget.currentState?.shake(),
                child: const Text('ゆっくり震える'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    required this.child,
    this.offset = 10,
    this.count = 3,
    this.duration = const Duration(milliseconds: 300),
    this.noStop = false,
  }) : super(key: key);

  final Widget child;
  final double offset;
  final int count;
  final Duration duration;
  final bool noStop;

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final _animationController =
      AnimationController(vsync: this, duration: widget.duration);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.count * 2 * pi * _animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.offset, 0),
          child: child,
        );
      },
    );
  }

  void shake() {
    _animationController
        .forward()
        .whenComplete(() => _animationController.reset());
  }
}
