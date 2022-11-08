import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

main() {
  test('list', () async {
    final list1 = [1, 2, 3];
    final list2 = [1, 2, 3];
    final list3 = [1, 3, 2];

    expect(ListEquality().equals(list1, list2), true);
    expect(ListEquality().equals(list1, list3), false);

    expect(DeepCollectionEquality().equals(list1, list2), true);
    expect(DeepCollectionEquality().equals(list1, list3), false);

    expect(DeepCollectionEquality.unordered().equals(list1, list2), true);
    expect(DeepCollectionEquality.unordered().equals(list1, list3), true);
  });

  test('set', () async {
    final set1 = {1, 2, 3};
    final set2 = {2, 3, 1};
    final set3 = {1, 2, 3, 4};

    expect(SetEquality().equals(set1, set2), true);
    expect(SetEquality().equals(set1, set3), false);
  });

  test('map', () async {
    final map1 = {1: 1, 2: 2};
    final map2 = {2: 2, 1: 1};
    final map3 = {1: 1, 3: 3};

    expect(MapEquality().equals(map1, map2), true);
    expect(MapEquality().equals(map1, map3), false);
  });
}
