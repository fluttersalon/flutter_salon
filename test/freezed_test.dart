import 'package:flutter_test/flutter_test.dart';

import 'data/data.dart';

main() {
  test('toJson with null', () async {
    var target = Data(title: 'title', noJson: 'test');
    var result = target.toJson();
    expect(result['title'], 'title');
    expect(result.containsKey('noJson'), false);
    expect(result.containsKey('noJsonNullable'), false);
    expect(result.containsKey('list'), false);
    expect(result.containsKey('noJsonNullable'), false);
  });

  test('toJson without null', () async {
    var target = Data(
        title: 'title',
        noJson: 'test',
        noJsonNullable: 'testNullable',
        list: [],
        listNullable: ['a', 'b']);
    var result = target.toJson();
    expect(result['title'], 'title');
    expect(result.containsKey('noJson'), false);
    expect(result.containsKey('noJsonNullable'), false);
    expect(result.containsKey('list'), false);
    expect(result.containsKey('noJsonNullable'), false);
  });

  test('fromJson', () async {
    var map = <String, dynamic>{'title': 'title'};
    var result = Data.fromJson(map);
    expect(result.title, 'title');
    expect(result.noJson, 'default');
    expect(result.noJsonNullable, null);
    expect(result.list, []);
    expect(result.noJsonNullable, null);
  });
}
