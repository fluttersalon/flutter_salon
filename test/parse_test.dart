import 'package:flutter_test/flutter_test.dart';

main() {
  test('parse', () {
    expect(int.parse('1'), 1);
    try {
      int.parse('source');
      fail('message');
    } catch (e) {}

    expect(int.tryParse('1'), 1);
    expect(int.tryParse('a'), null);
  });
}
