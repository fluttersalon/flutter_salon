import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ProviderScope(child: const MyApp()));
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
  static const githubUrl =
      'https://api.github.com/search/repositories?q=[keyword]&page=[page]';

  int _page = 1;

  final _titlesProvider = StateProvider<List<String>>((ref) => []);
  final _loadingProvider = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          if (_page == 1) {
            // 初回のデータ読み込み
            loadTitles(githubUrl, _page++, 'flutter').then(
                (data) => ref.read(_titlesProvider.notifier).state = data);
          }

          final titles = ref.watch(_titlesProvider);
          final loading = ref.watch(_loadingProvider);

          if (titles.isEmpty) {
            return CircularProgressIndicator();
          }

          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification notification) {
              // スクロールの最後に到達してない場合
              if (0 < notification.metrics.extentAfter) {
                return false;
              }

              // すでにデータを読み込んでいる場合、再度の読込はしない
              if (ref.read(_loadingProvider)) {
                return true;
              }

              ref.read(_loadingProvider.notifier).state = true;
              loadTitles(githubUrl, _page++, 'flutter').then((data) {
                ref.read(_loadingProvider.notifier).state = false;
                ref
                    .read(_titlesProvider.notifier)
                    .update((state) => [...state, ...data]);
              });
              return true;
            },
            child: ListView.builder(
              // 読込中は、データの最後に読込中マークを表示するため、
              // Listのデータにプラス1する
              itemCount: titles.length + (loading ? 1 : 0),
              itemBuilder: (context, index) => Card(
                child: SizedBox(
                  height: 50,
                  // 読み込み中かつ最後のWidgetの場合、読込中マークする
                  child: loading && index == titles.length
                      ? const CircularProgressIndicator()
                      : Text(titles[index]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<List<String>> loadTitles(
      String baseUrl, int page, String keyword) async {
    final url = baseUrl
        .replaceAll('[keyword]', keyword)
        .replaceAll('[page]', page.toString());

    print('url: $url');

    final client = http.Client();
    final response = await client.get(Uri.parse(url));
    final map = json.decode(response.body) as Map<String, dynamic>;

    final items = map['items'] as List<dynamic>;
    final result = <String>[];
    for (final item in items) {
      result.add(item['name'].toString());
    }

    // 以下ではうまく行かなかった
    //final titleList = map['items'].map((e) => e['name'].toString()).toList();
    return result;
  }
}
