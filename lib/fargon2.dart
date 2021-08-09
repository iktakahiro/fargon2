import 'dart:async';

import 'package:flutter/services.dart';

enum Fargon2Mode {
  argon2i,
  argon2d,
  argon2id,
}

extension Fargon2ModeString on Fargon2Mode {
  String get string {
    switch (this) {
      case Fargon2Mode.argon2i:
        return 'argon2i';
      case Fargon2Mode.argon2d:
        return 'argon2d';
      case Fargon2Mode.argon2id:
      default:
        return 'argon2id';
    }
  }
}

class Fargon2 {
  const Fargon2({
    required this.mode,
  });
  static const MethodChannel _channel = const MethodChannel('fargon2');

  final Fargon2Mode mode;

  Future<String> hash({
    required String passphrase,
    required String salt,
    int hashLength = 32,
    int iterations = 3,
    int parallelism = 2,
    int memoryKibibytes = 65536,
  }) async {
    final params = <String, dynamic>{
      'mode': mode.string,
      'password': passphrase,
      'salt': salt,
      'hash_length': hashLength,
      'iterations': iterations,
      'parallelism': parallelism,
      'memory_kibibytes': memoryKibibytes,
    };
    if (salt.length < 8) {
      throw Fargon2ArgumentError(
        'salt is too short. It must be at least 8 characters.',
      );
    }
    final String result = await _channel.invokeMethod('hash', params);

    return result.replaceAll('\n', '');
  }
}

class Fargon2ArgumentError implements Exception {
  final String msg;
  const Fargon2ArgumentError(this.msg);
  String toString() => 'Fargon2ArgumentError: $msg';
}
