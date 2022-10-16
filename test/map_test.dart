import 'package:flutter_test/flutter_test.dart';

main() {
  test('add', () async {
    final key1 = 'key1';
    final key2 = 'key2';
    final key3 = 'key3';

    final map = <String, List<int>>{};

    // キーがないと、addAll は使えない
    expect(map.containsKey(key1), false);
    map[key1]?.addAll([1, 2, 3]);
    expect(map.containsKey(key1), false);

    map[key1] = [1, 2, 3];
    expect(map.containsKey(key1), true);

    expect(map.containsKey(key2), false);
    map.putIfAbsent(key2, () => [4, 5, 6]);
    expect(map.containsKey(key2), true);

    expect(map.containsKey(key3), false);
    final list1 = [7, 8, 9];
    map.update(key3, (value) => [...value, ...list1], ifAbsent: () => list1);
    expect(map.containsKey(key3), true);
    expect(map[key3]?.length, 3);

    final newData = [10, 11, 12];
    map.update(key3, (existData) => [...existData, ...newData],
        ifAbsent: () => newData);
    expect(map[key3]?.length, 6);

    final key3Data = map[key3]!;
    expect(key3Data[0], 7);
    expect(key3Data[1], 8);
    expect(key3Data[2], 9);
    expect(key3Data[3], 10);
    expect(key3Data[4], 11);
    expect(key3Data[5], 12);
  });
}
