import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fargon2/fargon2.dart';

void main() {
  const MethodChannel channel = MethodChannel('fargon2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "hash") {
        return 'r3JRsauJmoPZxb7pQ036AtD6RVy+EZcwsV6BQmBI0Do=';
      }
      return '';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('hash()', () {
    test('should return a hash string', () async {
      final fargon2 = Fargon2(mode: Fargon2Mode.argon2id);
      expect(
        await fargon2.hash(
          passphrase: 'mypassphrase',
          salt: 'mysalt01',
        ),
        'r3JRsauJmoPZxb7pQ036AtD6RVy+EZcwsV6BQmBI0Do=',
      );
    });
  });
}
