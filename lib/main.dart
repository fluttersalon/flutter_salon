import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: SunAndMoonCoin(
        size: 64,
        callback: (CoinStatus status) {
          if (status == CoinStatus.sun) {
            _incrementCounter();
          }
        },
      ),
    );
  }
}

/// コインの状態
enum CoinStatus {
  /// 太陽
  sun,

  /// 月
  moon;
}

/// 太陽と月がそれぞれ表と裏に書かれているコインをイメージして作成しました。
class SunAndMoonCoin extends StatefulWidget {
  const SunAndMoonCoin({
    super.key,
    this.callback,
    this.duration = const Duration(milliseconds: 100),
    this.initStatus = CoinStatus.sun,
    this.size = 32,
    this.color = Colors.orangeAccent,
  });

  /// 太陽と月が入れ替わるときに実施されるコールバックを設定します
  /// 例：テーマの入れ替え
  final void Function(CoinStatus coinStatus)? callback;

  /// アニメーションの時間
  final Duration duration;

  ///初期状態
  final CoinStatus initStatus;

  /// サイズ
  final double size;

  ///アイコンの色
  final Color color;

  @override
  State<SunAndMoonCoin> createState() => _SunAndMoonCoinState();
}

class _SunAndMoonCoinState extends State<SunAndMoonCoin>
    with SingleTickerProviderStateMixin<SunAndMoonCoin> {
  /// 太陽のアイコン
  late final sunIcon = SvgPicture.asset(
    'assets/images/day_icon.svg',
    color: widget.color,
    height: widget.size,
    width: widget.size,
  );

  /// 月のアイコン
  late final moonIcon = SvgPicture.asset(
    'assets/images/night_icon.svg',
    color: widget.color,
    height: widget.size,
    width: widget.size,
  );

  /// アニメーションの値の初期値
  static const startValue = 0.0;

  /// アニメーションの値の終了値
  static const endValue = 1.0;

  /// コインの表裏の入れ替わり値
  static const breakValue = (startValue + endValue) / 2;

  /// 現在の状態
  CoinStatus _currentStatus = CoinStatus.sun;

  /// アニメーションのコントローラ
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  // アニメーションで変化する値
  late final Animation<double> _animationValue =
      Tween(begin: startValue, end: endValue).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  )..addListener(
          () {
            // 太陽→月に変えるタイミング
            if (_currentStatus == CoinStatus.sun &&
                breakValue < _animationValue.value) {
              _currentStatus = CoinStatus.moon;
              _callback();
            }
            //  月→太陽 に変えるタイミング
            else if (_currentStatus == CoinStatus.moon &&
                _animationValue.value < breakValue) {
              _currentStatus = CoinStatus.sun;
              _callback();
            }
          },
        );

  /// 太陽と月が入れ替わるときにコースバックを実施する
  void _callback() {
    if (widget.callback != null) {
      widget.callback!(_currentStatus);
    }
  }

  @override
  void initState() {
    super.initState();

    // 初期値が月だった場合、月のアイコンにして、アニメーションを進めておく
    if (widget.initStatus == CoinStatus.moon) {
      _currentStatus = CoinStatus.moon;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationValue.value == startValue) {
          _controller.forward();
        } else if (_animationValue.value == endValue) {
          _controller.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(math.pi * (1.0 - _animationValue.value)),
            child: _currentStatus == CoinStatus.sun ? sunIcon : moonIcon,
          );
        },
      ),
    );
  }
}
