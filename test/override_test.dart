import 'package:flutter_test/flutter_test.dart';

class Parent {
  String test() => 'parent';
  String callTest() {
    return test();
  }
}

class Child1 extends Parent {
  @override
  String test() => 'child1';
}

class Child2 extends Parent {
  @override
  String test() => 'child2';
}

main() {
  test('', () async {
    Parent parent = Parent();
    expect(parent.test(), 'parent');
    expect(parent.callTest(), 'parent');

    Child1 child1 = Child1();
    expect(child1.test(), 'child1');
    expect(child1.callTest(), 'child1');

    Child2 child2 = Child2();
    expect(child2.test(), 'child2');
    expect(child2.callTest(), 'child2');

    Parent child1_ = Child1();
    expect(child1_.test(), 'child1');
    expect(child1_.callTest(), 'child1');
  });
}
