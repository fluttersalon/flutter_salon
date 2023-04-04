import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final Animation<Color?> _animatinColor = ColorTween(
    begin: Colors.blue,
    end: Colors.red,
  ).animate(_controller);

  bool _isForward = false;

  Color _bottomColor = Colors.blue;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Animation Color')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                  animation: _animatinColor,
                  builder: (context, child) {
                    return FilledButton(
                      onPressed: () {
                        if (_isForward) {
                          _controller.reverse();
                        } else {
                          _controller.forward();
                        }
                        setState(() {
                          _isForward = !_isForward;
                        });
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: _animatinColor.value),
                      child: child,
                    );
                  },
                  child: Text(_isForward ? '青にする' : '赤にする')),
              TweenAnimationBuilder(
                tween: ColorTween(end: _bottomColor),
                duration: const Duration(seconds: 1),
                builder: (BuildContext context, Color? color, Widget? child) {
                  return FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: color),
                    onPressed: () {
                      setState(() {
                        _bottomColor = _bottomColor == Colors.blue
                            ? Colors.red
                            : Colors.blue;
                      });
                    },
                    child: child,
                  );
                },
                child: Text(_bottomColor != Colors.blue ? '青にする' : '赤にする'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
