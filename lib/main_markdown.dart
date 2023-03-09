import 'package:flutter/material.dart';

//  flutter pub remove markdown_widget
// flutter pub add flutter_markdown
//import 'package:flutter_markdown/flutter_markdown.dart';

//  flutter pub remove flutter_markdown
// flutter pub add markdown_widget
import 'package:markdown_widget/widget/markdown.dart';

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
      home: const MyHomePage(title: 'flutter_markdown Demo'),
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
        child: MarkdownWidget(
          // child: Markdown(
          data: markdownText,
        ),
      ),
    );
  }

  final String markdownText = '''
# Markdownパッケージの実線(# h1)
## 強調関連(## h2)
### サブタイトル(### h3)
#### サブ・サブタイトル(#### h4)
通常
**強調** 
*斜線* 
~取消~ 

## リンク
[リンク](https://www.google.com)

## 改行
空白行あり→改行できる 

空白行なし
→改行できない

## Details - 折りたたみ
<details><summary>サンプルコード</summary>

(上に空行が必要)

```rb
puts 'Hello, World'
```
</details>

### リスト
- リスト1
- リスト2

## 画像
![Qiita](https://qiita-image-store.s3.amazonaws.com/0/45617/015bd058-7ea0-e6a5-b9cb-36a4fb38e59c.png "Qiita")

<img width="50" src="https://qiita-image-store.s3.amazonaws.com/0/45617/015bd058-7ea0-e6a5-b9cb-36a4fb38e59c.png">
## テーブル
| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| column     | column      | column       |

## 終わり
''';
}
