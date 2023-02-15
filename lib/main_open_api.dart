import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';

const kOpenApiKey = '[OpenAIのAPIキー]';

void main() {
  OpenAI.apiKey = kOpenApiKey;

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
      home: const MyHomePage(title: 'Flutter OpenAI Demo'),
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
  late final Future<OpenAIImageModel> futureImages =
      OpenAI.instance.image.create(
    prompt: '三匹の子猫',
    n: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<OpenAIImageModel>(
          future: futureImages,
          builder:
              (BuildContext context, AsyncSnapshot<OpenAIImageModel> snapshot) {
            if (snapshot.hasError) {
              return Text('エラー:${snapshot.error!.toString()}');
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator.adaptive();
            }

            final images = snapshot.data!.data;
            return ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(images[index].url);
                });
          },
        ),
      ),
    );
  }
}
