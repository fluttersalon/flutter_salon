import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class Item {
  Item(this.name, this.price);
  final String name;
  final int price;
}

main() {
  test('most expensive', () {
    final list = [
      Item('name1', 100),
      Item('name2', 200),
      Item('name3', 400),
      Item('name4', 300),
    ];

    final mostExpensive =
        list.reduce((e1, e2) => e1.price > e2.price ? e1 : e2);
    expect(mostExpensive.name, 'name3');
  });

  Item mostExpensiveItem(Item e1, Item e2) => e1.price > e2.price ? e1 : e2;
  test('most expensive function', () {
    final list = [
      Item('name1', 100),
      Item('name2', 200),
      Item('name3', 400),
      Item('name4', 300),
    ];

    final mostExpensive = list.reduce(mostExpensiveItem);
    expect(mostExpensive.name, 'name3');
  });

  test('no item', () {
    final list = <Item>[];

    expect(() => list.reduce(mostExpensiveItem),
        throwsA(isInstanceOf<StateError>()));
  });

  test('one item', () {
    final list = <Item>[
      Item('name1', 100),
    ];

    final mostExpensive = list.reduce(mostExpensiveItem);
    expect(mostExpensive.name, 'name1');
  });

  test('max', () {
    final list = [100, 200, 400, 300];

    final maxValue = list.reduce(max);
    expect(maxValue, 400);

    expect(list.reduce(min), 100);
  });
}
