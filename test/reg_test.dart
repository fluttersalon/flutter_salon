import 'package:flutter_test/flutter_test.dart';

main() {
  test('基本', () {
    var reg1 = RegExp(r'^[Aa]+$');
    expect(reg1.hasMatch('A'), true);
    expect(reg1.hasMatch('Aa'), true);
    expect(reg1.hasMatch('AaAA'), true);

    expect(reg1.hasMatch('bAa'), false);
    expect(reg1.hasMatch('Aab'), false);
    expect(reg1.hasMatch('Aba'), false);
  });

  test('数字7桁', () {
    var reg1 = RegExp(r'^[0-9]{7}$');
    expect(reg1.hasMatch('1234567'), true);
    expect(reg1.hasMatch('0234567'), true);
    expect(reg1.hasMatch('1234569'), true);

    expect(reg1.hasMatch('123456'), false);
    expect(reg1.hasMatch('_234567'), false);
    expect(reg1.hasMatch('1234_67'), false);
    expect(reg1.hasMatch('123456_'), false);
  });

  test('数字7桁-2', () {
    var reg1 = RegExp(r'^\d{7}$');
    expect(reg1.hasMatch('1234567'), true);
    expect(reg1.hasMatch('0234567'), true);
    expect(reg1.hasMatch('1234569'), true);

    expect(reg1.hasMatch('123456'), false);
    expect(reg1.hasMatch('_234567'), false);
    expect(reg1.hasMatch('1234_67'), false);
    expect(reg1.hasMatch('123456_'), false);
  });
}
