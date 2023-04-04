import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';

main() async {
  test('read', () async {
    final file = File('test/test.png');
    expect(file.existsSync(), true);

    final data = await file.readAsBytes();
    expect(data.lengthInBytes, 816321);

    Uint8List bytes = await file.readAsBytes();
    expect(
      bytes.getRange(0, 8),
      [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A],
    );

    // 長さ:14
    expect(bytes.getRange(8, 8 + 4), [0x00, 0x00, 0x00, 0x0D]);

    // Chunk Typeを示す4文字 IHDR
    expect(bytes.getRange(12, 12 + 4), [0x49, 0x48, 0x44, 0x52]);

    //16 - 16+14:チャンクのデータ
    // 30 - 34: CRC

    // 文章の長さ
    expect(bytes.getRange(33, 33 + 4), [0x00, 0x00, 0x02, 0x9C]);
    ByteData bd =
        ByteData.view(Uint8List.fromList([0x00, 0x00, 0x02, 0x9C]).buffer);
    expect(bd.getInt32(0), 668);

    expect(String.fromCharCodes(bytes.getRange(37, 37 + 4)), 'tEXt');

    //パラメータ
    expect(
        String.fromCharCodes(bytes.getRange(41, 41 + 668)),
        '''
parameters\x00flower, (lens flare:0.75),(2 girl:1.1) ,(cheek-to-cheek:1.1),hold hands, black short hair, pink short hair
Negative prompt: (EasyNegative:0.9),(bad_prompt_version2:0.8),(lowers, low quality, worst quality:1.4),(bad anatomy:1.3),(nsfw1.1), (large breasts:0.8),(nipples:1.0),text, (long hair:0.8),(hips:0.2),(thigh:0.2),muscular,muscle ,exposed shoulders,(monochrome:1.1),BREAK, (blurry:1.4), (blurry background:1.4), (soft focus:1.1), out focus,,(whiteout:1.0), bokeh,film grain, watermark,(blue eye:0.8),(blonde hair:1.1),,car
Steps: 20, Sampler: DPM++ SDE Karras, CFG scale: 7, Seed: 1557464711, Size: 512x1024, Model hash: 7234b76e42, Model: chilloutmixni
    '''
            .trim());
  });

  test('stream', () async {
    final file = File('test/test.png');
    expect(file.existsSync(), true);

    final data = await file.readAsBytes();
    expect(data.lengthInBytes, 816321);

    var stream = file.openRead();

    stream.transform(StreamTransformer.fromBind((stream) {
      var controller = StreamController<List<int>>();
      var buffer = <int>[];

      stream.listen(
        (data) {
          buffer.addAll(data);

          if (buffer.length >= 1024) {
            controller.add(buffer);
            buffer = [];
          }
        },
        onError: controller.addError,
        onDone: () {
          if (buffer.isNotEmpty) {
            controller.add(buffer);
          }
          controller.close();
        },
      );

      return controller.stream;
    })).listen((data) {});
  });
}
