import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fargon2/fargon2.dart';

void main() {
  const channel = MethodChannel('fargon2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'hash') {
        return 'p8kGaAwsB0ZZhs/a1yEUcQ==';
      }
      return '';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('hash()', () {
    test('should return a hash string.', () async {
      final fargon2 = Fargon2(mode: Fargon2Mode.argon2id);
      expect(
        await fargon2.hash(
          passphrase: 'mypassphrase',
          salt: 'mysalt01',
        ),
        'p8kGaAwsB0ZZhs/a1yEUcQ==',
      );
    });

    test('should throw Fargon2ArgumentError when a salt is short.', () async {
      final fargon2 = Fargon2(mode: Fargon2Mode.argon2id);

      expect(
        () async => await fargon2.hash(
          passphrase: 'mypassphrase',
          salt: 'char',
        ),
        throwsA(
          predicate((e) =>
              e is Fargon2ArgumentError &&
              e.toString() ==
                  'Fargon2ArgumentError: salt is too short. It must be at least 8 characters.'),
        ),
      );
    });
  });
}
