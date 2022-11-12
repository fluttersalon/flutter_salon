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

  test('正規表現による文字列チェック', () {
    final regA = RegExp(r'A');
    expect(regA.hasMatch('A'), true);
    expect(regA.hasMatch('aA'), true);
    expect(regA.hasMatch('Aa'), true);

    expect(regA.hasMatch('a'), false);
  });
  test('正規表現に一致する文字列を抽出', () {
    final regA = RegExp(r'A');

    final matchOne = regA.firstMatch('A');
    expect(matchOne!.groupCount, 0);
    expect(matchOne.group(0), 'A');

    final matchNone = regA.firstMatch('a');
    expect(matchNone, null);

    final matchOne2 = regA.firstMatch('AaA');
    expect(matchOne2!.groupCount, 0);
    expect(matchOne2.group(0), 'A');

    final matchSome = regA.allMatches('AaA');
    expect(matchSome.length, 2);
    expect(matchSome.toList()[0].group(0), 'A');
    expect(matchSome.toList()[1].group(0), 'A');
  });

  test('正規表現で一致する文字列を置換', () {
    final regA = RegExp(r'A');
    expect('A'.replaceFirst(regA, 'B'), 'B');
    expect('AaA'.replaceFirst(regA, 'B'), 'BaA');
    expect('AaA'.replaceAll(regA, 'B'), 'BaB');
  });

  test('文字列の開始・終了への一致', () {
    final regStartWithA = RegExp(r'^A');
    final regEndWithA = RegExp(r'A$');
    final regOnlyA = RegExp(r'^A$');

    expect(regStartWithA.hasMatch('A'), true);
    expect(regEndWithA.hasMatch('A'), true);
    expect(regOnlyA.hasMatch('A'), true);

    expect(regStartWithA.hasMatch('Aab'), true);
    expect(regEndWithA.hasMatch('Aab'), false);
    expect(regOnlyA.hasMatch('Aab'), false);

    expect(regStartWithA.hasMatch('abA'), false);
    expect(regEndWithA.hasMatch('abA'), true);
    expect(regOnlyA.hasMatch('abA'), false);
  });

  test('複数行にマッチ', () {
    const lineN = '1END\n2END\n3END';
    const lineRn = '1END\r\n2END\r\n3END';

    final regDefault = RegExp(r'END$');
    final regSingleLine = RegExp(r'END$', multiLine: false);
    final regMultiLine = RegExp(r'END$', multiLine: true);

    expect(regDefault.allMatches(lineN).length, 1);
    expect(regDefault.allMatches(lineRn).length, 1);

    expect(regSingleLine.allMatches(lineN).length, 1);
    expect(regSingleLine.allMatches(lineRn).length, 1);

    expect(regMultiLine.allMatches(lineN).length, 3);
    expect(regMultiLine.allMatches(lineRn).length, 3);
  });

  test('連続した文字列', () {
    final reg = RegExp(r'ABC');
    expect(reg.hasMatch('ABC'), true);
    expect(reg.hasMatch('aABC'), true);
    expect(reg.hasMatch('ABCc'), true);

    expect(reg.hasMatch('AbC'), false);
  });

  test('どれかの文字', () {
    final reg = RegExp(r'[ABC]');
    expect(reg.hasMatch('A'), true);
    expect(reg.hasMatch('B'), true);
    expect(reg.hasMatch('C'), true);

    expect(reg.hasMatch('Abc'), true);
    expect(reg.hasMatch('aBc'), true);
    expect(reg.hasMatch('abC'), true);

    expect(reg.hasMatch('abc'), false);
  });

  test('任意の文字列', () {
    final reg = RegExp(r'c.t');
    expect(reg.hasMatch('cat'), true);
    expect(reg.hasMatch('cut'), true);
    expect(reg.hasMatch('cutboard'), true);

    expect(reg.hasMatch('ct'), false);
    expect(reg.hasMatch('cuT'), false);
  });

  test('12のメタ文字には、\をつける', () {
    // $()*+.?[\^{|

    final regDot = RegExp(r'c\.t');
    expect(regDot.hasMatch('cat'), false);
    expect(regDot.hasMatch('c.t'), true);

    // RegExp(r'[');
    // ⇒] がないので、実行エラー
    final regOpen = RegExp(r'\[');
    final regClose = RegExp(r']');

    expect(regOpen.hasMatch('[]'), true);
    expect(regClose.hasMatch('[]'), true);
  });

  test('文字の連続', () {
    final regZeroOrMore = RegExp(r'A*');
    final regOneOrMore = RegExp(r'A+');

    expect(regZeroOrMore.hasMatch('a'), true);
    expect(regOneOrMore.hasMatch('a'), false);

    expect(regZeroOrMore.hasMatch('Aa'), true);
    expect(regOneOrMore.hasMatch('Aa'), true);

    // ?: 0か1の連続
    final regZeroOrOne = RegExp(r'cou?lor');
    expect(regZeroOrOne.hasMatch('color'), true);
    expect(regZeroOrOne.hasMatch('coulor'), true);
    expect(regZeroOrOne.hasMatch('c_lor'), false);
    expect(regZeroOrOne.hasMatch('c_ulor'), false);

    final regTwo = RegExp(r'^A{2}$');
    final regTwoOrMore = RegExp(r'^A{2,}$');
    final regBetweenTwoAndFour = RegExp(r'^A{2,4}$');

    expect(regTwo.hasMatch('A'), false);
    expect(regTwoOrMore.hasMatch('A'), false);
    expect(regBetweenTwoAndFour.hasMatch('A'), false);

    expect(regTwo.hasMatch('AA'), true);
    expect(regTwoOrMore.hasMatch('AA'), true);
    expect(regBetweenTwoAndFour.hasMatch('AA'), true);

    expect(regTwo.hasMatch('AAA'), false);
    expect(regTwoOrMore.hasMatch('AAA'), true);
    expect(regBetweenTwoAndFour.hasMatch('AAA'), true);

    expect(regTwo.hasMatch('AAAA'), false);
    expect(regTwoOrMore.hasMatch('AAAA'), true);
    expect(regBetweenTwoAndFour.hasMatch('AAAA'), true);

    expect(regTwo.hasMatch('AAAAA'), false);
    expect(regTwoOrMore.hasMatch('AAAAA'), true);
    expect(regBetweenTwoAndFour.hasMatch('AAAAA'), false);
  });

  test('単語 \b', () {
    final reg = RegExp(r'\bcat\b');
    expect(reg.hasMatch('cat'), true);
    expect(reg.hasMatch('cats'), false);

    expect(reg.hasMatch('animal cat dog'), true);
    expect(reg.hasMatch('animal cats dog'), false);
  });

  test('数字・数字以外 \d \D', () {
    final regNumber = RegExp(r'\d');
    final regNotNumber = RegExp(r'\D');

    expect(regNumber.hasMatch('0'), true);
    expect(regNotNumber.hasMatch('0'), false);

    expect(regNumber.hasMatch('A'), false);
    expect(regNotNumber.hasMatch('A'), true);
  });

  test('アルファベット&アンダーバー&数字・それ以外 \w \W', () {
    final regWord = RegExp(r'\w');
    final regNotWord = RegExp(r'\W');

    expect(regWord.hasMatch('0'), true);
    expect(regNotWord.hasMatch('0'), false);

    expect(regWord.hasMatch('A'), true);
    expect(regNotWord.hasMatch('A'), false);

    expect(regWord.hasMatch('_'), true);
    expect(regNotWord.hasMatch('_'), false);

    expect(regWord.hasMatch('.'), false);
    expect(regNotWord.hasMatch('.'), true);

    expect(regWord.hasMatch('!@#%^&*()+='), false);
    expect(regNotWord.hasMatch('!@#%^&*()+='), true);
  });

  test('否定', () {
    final regNotOne = RegExp(r'[^A]');
    final regNotSome = RegExp(r'[^ABC]');

    expect(regNotOne.hasMatch('A'), false);
    expect(regNotSome.hasMatch('A'), false);

    expect(regNotOne.hasMatch('ABC'), true);
    expect(regNotSome.hasMatch('ABC'), false);

    expect(regNotOne.hasMatch('BCA'), true);
    expect(regNotSome.hasMatch('BCA'), false);

    expect(regNotOne.hasMatch('ABCD'), true);
    expect(regNotSome.hasMatch('ABCD'), true);
  });

  test('連続した文字', () {
    final regZeroToFive = RegExp(r'[0-5]');
    expect(regZeroToFive.hasMatch('0'), true);
    expect(regZeroToFive.hasMatch('1'), true);
    expect(regZeroToFive.hasMatch('3'), true);
    expect(regZeroToFive.hasMatch('5'), true);

    expect(regZeroToFive.hasMatch('6'), false);
    expect(regZeroToFive.hasMatch('9'), false);

    final regAtoE = RegExp(r'[A-E]');
    expect(regAtoE.hasMatch('A'), true);
    expect(regAtoE.hasMatch('C'), true);
    expect(regAtoE.hasMatch('E'), true);

    expect(regAtoE.hasMatch('F'), false);
    expect(regAtoE.hasMatch('a'), false);
  });

  test('範囲を表さないマイナスは隅に寄せる', () {
    final reg1_9 = RegExp(r'[1-9]');
    final reg19_ = RegExp(r'[19-]');
    final reg_19 = RegExp(r'[-19]');

    expect(reg1_9.hasMatch('8'), true);
    expect(reg_19.hasMatch('8'), false);
    expect(reg19_.hasMatch('8'), false);

    expect(reg1_9.hasMatch('-'), false);
    expect(reg_19.hasMatch('-'), true);
    expect(reg19_.hasMatch('-'), true);
  });

  test(']を[]で使用するときは、\をつける', () {
    final reg = RegExp(r'[AB\]]');
    final regNot = RegExp(r'[^\]AB]');

    expect(reg.hasMatch('A'), true);
    expect(reg.hasMatch(']'), true);
    expect(reg.hasMatch('C'), false);

    expect(regNot.hasMatch('A'), false);
    expect(regNot.hasMatch(']'), false);
    expect(regNot.hasMatch('C'), true);
  });

  test('グループを取得', () {
    final regGroup = RegExp(r'^http://([^/]+)/(.+)$');
    final matches =
        regGroup.allMatches('http://domain.com/path1/path2').toList();
    expect(matches.length, 1);

    var match = matches[0];
    expect(match.groupCount, 2);
    expect(match.group(0), 'http://domain.com/path1/path2');
    expect(match.group(1), 'domain.com');
    expect(match.group(2), 'path1/path2');
  });

  test('グループ名で取得', () {
    final regGroup = RegExp(r'^http://(?<domain>[^/]+)/(?<path>.+)$');
    final matches =
        regGroup.allMatches('http://domain.com/path1/path2').toList();
    expect(matches.length, 1);

    var match = matches[0];
    expect(match.groupCount, 2);

    final groupNames = match.groupNames.toList();
    expect(groupNames.length, 2);
    expect(groupNames[0], 'domain');
    expect(groupNames[1], 'path');

    expect(match.group(0), 'http://domain.com/path1/path2');
    expect(match.group(1), 'domain.com');
    expect(match.namedGroup('domain'), 'domain.com');
    expect(match.group(2), 'path1/path2');
    expect(match.namedGroup('path'), 'path1/path2');

    // グループ名を間違えると、ArgumentError が発行される
    expect(() => match.namedGroup('wrongName'),
        throwsA(isInstanceOf<ArgumentError>()));
  });
  test('パターンのグループ', () {
    final reg = RegExp(r'c(?:at|ut)');
    expect(reg.hasMatch('cat'), true);
    expect(reg.hasMatch('cut'), true);
    expect(reg.hasMatch('cute'), true);

    expect(reg.hasMatch('c'), false);
    expect(reg.hasMatch('cote'), false);

    final regName = RegExp(r'c(?<name>at|ut)');
    expect(regName.firstMatch('cat')!.namedGroup('name'), 'at');
    expect(regName.firstMatch('cut')!.namedGroup('name'), 'ut');
  });

  test('グループでリピート', () async {
    final regRepease = RegExp(r'^c(at|ut)+$');
    expect(regRepease.hasMatch('cat'), true);
    expect(regRepease.hasMatch('catut'), true);
    expect(regRepease.hasMatch('catcut'), false);
  });

  test('最終的にマッチに加わらない部分(先読み・後読み)', () {
    final reg = RegExp(r'(?<=<b>)\w*(?=</b>)');

    expect(reg.firstMatch('<b>cat</b>')!.group(0), 'cat');

    final matches = reg.allMatches('<b>cat</b>1234<b>dog</b>5678<b>fox</b>90');
    expect(matches.length, 3);
    final result = <String>[];
    for (final match in matches) {
      result.add(match.group(0)!);
    }

    expect(result[0], 'cat');
    expect(result[1], 'dog');
    expect(result[2], 'fox');
  });

  test('郵便番号の確認', () {
    final regPostalCode = RegExp(r'^\d{3}-?\d{4}$');

    expect(regPostalCode.hasMatch('1234567'), true);
    expect(regPostalCode.hasMatch('123-4567'), true);

    expect(regPostalCode.hasMatch('123--4567'), false);
    expect(regPostalCode.hasMatch('123456'), false);
    expect(regPostalCode.hasMatch('12345678'), false);
    expect(regPostalCode.hasMatch('1234-567'), false);
    expect(regPostalCode.hasMatch('123-456'), false);
    expect(regPostalCode.hasMatch('123-45678'), false);
  });

  test('郵便番号を変換', () {
    final regPostalCode = RegExp(r'^(\d{3})-?(\d{4})$');

    final match = regPostalCode.firstMatch('1234567')!;
    expect('${match.group(1)}${match.group(2)}', '1234567');
    expect('${match.group(1)}-${match.group(2)}', '123-4567');

    final matchMinus = regPostalCode.firstMatch('123-4567')!;
    expect('${matchMinus.group(1)}${matchMinus.group(2)}', '1234567');
    expect('${matchMinus.group(1)}-${matchMinus.group(2)}', '123-4567');
  });

  test('大文字小文字を区別しない', () {
    final regDefault = RegExp(r'A');
    final regSensitive = RegExp(r'A', caseSensitive: true);
    final regNotSensitive = RegExp(r'A', caseSensitive: false);

    expect(regDefault.isCaseSensitive, true);
    expect(regSensitive.isCaseSensitive, true);
    expect(regNotSensitive.isCaseSensitive, false);

    expect(regDefault.hasMatch('a'), false);
    expect(regSensitive.hasMatch('a'), false);
    expect(regNotSensitive.hasMatch('a'), true);
  });

  test('メールアドレスの確認', () {
    final regEmail = RegExp(
      caseSensitive: false,
      r"^[\w!#$%&'*+/=?`{|}~^-]+(\.[\w!#$%&'*+/=?`{|}~^-]+)*@([A-Z0-9-]{2,6})\.(?:\w{3}|\w{2}\.\w{2})$",
    );

    expect(regEmail.hasMatch('aaaa@aaaa.com'), true);
    expect(regEmail.hasMatch('!.{}@aaaa.com'), true);
    expect(regEmail.hasMatch('aaaa@aaaa.co.jp'), true);

    expect(regEmail.hasMatch('aaaa.com'), false);
    expect(regEmail.hasMatch('aa@aaaaaaa.com'), false);
    expect(regEmail.hasMatch('.aaaa@aaaa.com'), false);
  });

  test('正規表現を分割', () {
    final reg = RegExp(r'ab' + r'cd');

    expect(reg.hasMatch('abcd'), true);
  });

  test('日付の確認', () {
    final regText = r'^(?<year>20[0-3][0-9])/(?:' +
        r'(?<month1>0?2)/(?<day1>[12][0-9]|0?[1-9])|' +
        r'(?<month2>0?[469]|11)/(?<day2>30|[12][0-9]|0?[1-9])|' + // 30日の月
        r'(?<month3>0?[13578]|1[02])/(?<day3>3[01]|[12][0-9]|0?[1-9])' + //31日の月
        r')$';
    final regDay = RegExp(regText);

    expect(regDay.hasMatch('1999/01/01'), false);
    expect(regDay.hasMatch('2000/01/01'), true);
    expect(regDay.hasMatch('2039/01/01'), true);
    expect(regDay.hasMatch('2040/01/01'), false);

    expect(regDay.hasMatch('2000/1/1'), true);
    expect(regDay.hasMatch('2000/1/01'), true);
    expect(regDay.hasMatch('2000/01/1'), true);

    expect(regDay.hasMatch('20000/01/1'), false);
    expect(regDay.hasMatch('02000/01/1'), false);
    expect(regDay.hasMatch('2000/001/1'), false);
    expect(regDay.hasMatch('2000/1/001'), false);

    expect(regDay.hasMatch('2022/02/01'), true);
    expect(regDay.hasMatch('2022/02/02'), true);
    expect(regDay.hasMatch('2022/02/09'), true);
    expect(regDay.hasMatch('2022/02/10'), true);
    expect(regDay.hasMatch('2022/02/29'), true);
    expect(regDay.hasMatch('2022/02/30'), false);

    expect(regDay.hasMatch('2022/04/01'), true);
    expect(regDay.hasMatch('2022/04/09'), true);
    expect(regDay.hasMatch('2022/04/10'), true);
    expect(regDay.hasMatch('2022/04/15'), true);
    expect(regDay.hasMatch('2022/04/19'), true);
    expect(regDay.hasMatch('2022/04/20'), true);
    expect(regDay.hasMatch('2022/04/21'), true);
    expect(regDay.hasMatch('2022/04/29'), true);
    expect(regDay.hasMatch('2022/04/30'), true);
    expect(regDay.hasMatch('2022/04/31'), false);
    expect(regDay.hasMatch('2022/04/32'), false);

    expect(regDay.hasMatch('2022/04/31'), false);
    expect(regDay.hasMatch('2022/06/31'), false);
    expect(regDay.hasMatch('2022/09/31'), false);

    expect(regDay.hasMatch('2022/01/01'), true);
    expect(regDay.hasMatch('2022/01/09'), true);
    expect(regDay.hasMatch('2022/01/10'), true);
    expect(regDay.hasMatch('2022/01/15'), true);
    expect(regDay.hasMatch('2022/01/19'), true);
    expect(regDay.hasMatch('2022/01/20'), true);
    expect(regDay.hasMatch('2022/01/21'), true);
    expect(regDay.hasMatch('2022/01/29'), true);
    expect(regDay.hasMatch('2022/01/30'), true);
    expect(regDay.hasMatch('2022/01/31'), true);
    expect(regDay.hasMatch('2022/01/32'), false);

    final match = regDay.firstMatch('2022/01/01');
    expect(match!.groupNames.contains('month1'), true);
    expect(match.groupNames.contains('month2'), true);
    expect(match.groupNames.contains('month3'), true);

    expect(match.namedGroup('month1'), null);
    expect(match.namedGroup('month2'), null);
    expect(match.namedGroup('month3'), '01');
  });

  test('最大量指定子(欲張りな) と 最小量指定子(控えめな)', () {
    final regMore = RegExp(r'A*');
    final regLess = RegExp(r'A*?');
    final regOneAndMore = RegExp(r'A+');
    final regOneAndLess = RegExp(r'A+?');

    expect(regMore.firstMatch('AA')!.group(0), 'AA');
    expect(regLess.firstMatch('AA')!.group(0), '');
    expect(regOneAndMore.firstMatch('AA')!.group(0), 'AA');
    expect(regOneAndLess.firstMatch('AA')!.group(0), 'A');
  });

  test('複数回の一致しているケース', () {
    final reg = RegExp(r'AB');
    final match = reg.allMatches('AB1aAB2aAB3');
    expect(match.length, 3);
  });

  test('日本語', () {
    final regHiragana = RegExp('[\u3040-\u309F]');
    expect(regHiragana.hasMatch('あ'), true);
    expect(regHiragana.hasMatch('を'), true);
    expect(regHiragana.hasMatch('ぁ'), true);
    expect(regHiragana.hasMatch('だ'), true);

    expect(regHiragana.hasMatch('A'), false);
    expect(regHiragana.hasMatch('ア'), false);

    final regKatakana = RegExp('[\u30A0-\u30FF]');
    expect(regKatakana.hasMatch('ア'), true);
    expect(regKatakana.hasMatch('ヲ'), true);
    expect(regKatakana.hasMatch('ァ'), true);
    expect(regKatakana.hasMatch('ダ'), true);

    expect(regKatakana.hasMatch('A'), false);
    expect(regKatakana.hasMatch('あ'), false);

    final regKanji = RegExp('[\u4E00-\u9FFF]');
    expect(regKanji.hasMatch('亜'), true);
    expect(regKanji.hasMatch('正'), true);

    expect(regKanji.hasMatch('A'), false);
    expect(regKanji.hasMatch('あ'), false);
    expect(regKanji.hasMatch('ア'), false);
  });

  test('CSVファイルの一行をグループで読み込む', () async {
    const line = 'ナイトパレード,ハリウッドエリア,19:00';

    final regNo = RegExp(r'^([^,]*),([^,]*),(\d+):(\d{2})$');
    final matchNo = regNo.firstMatch(line);
    expect(matchNo, isNotNull);
    expect(matchNo!.group(1), 'ナイトパレード');
    expect(matchNo.group(2), 'ハリウッドエリア');
    expect(matchNo.group(3), '19');
    expect(matchNo.group(4), '00');

    final regNamed = RegExp(
        r'^(?<name>[^,]*),(?<place>[^,]*),(?<hour>\d+):(?<minute>\d{2})$');
    final matchNamed = regNamed.firstMatch(line);
    expect(matchNamed, isNotNull);
    expect(matchNamed!.namedGroup('name'), 'ナイトパレード');
    expect(matchNamed.namedGroup('place'), 'ハリウッドエリア');
    expect(matchNamed.namedGroup('hour'), '19');
    expect(matchNamed.namedGroup('minute'), '00');
  });
}
