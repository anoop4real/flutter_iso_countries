import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iso_countries/iso_countries.dart';

void main() {
  const MethodChannel channel = MethodChannel('iso_countries');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await IsoCountries.platformVersion, '42');
  });
}
