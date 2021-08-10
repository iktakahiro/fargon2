# fargon2

A plugin for generating a hash based on Argon2 algorithm in Android / iOS platform.

## What is Argon2

Argon2 is a password hashing algorithm. If you want to know more details, please refer to the following document

* https://github.com/P-H-C/phc-winner-argon2

## Getting Started

Add a dependency in your pubspec.yaml:

```yaml
dependencies:
  fargon2: ^0.0.1
```

```dart
import 'package:fargon2/fargon2.dart';

void main() {
  // mode options: argon2id, argon2i, argon2d
  final hash = await Fargon2(mode: Fargon2Mode.argon2id).hash(
        passphrase: 'mypassphrase',
        salt: 'mysalt01',
        hashLength: 16,
        iterations: 3,
        parallelism: 2,
        memoryKibibytes: 65536,
  );
  print(hash); // p8kGaAwsB0ZZhs/a1yEUcQ==
}
```

## Acknowledgments

This dart package is a wrapper of [CatCrypto](https://github.com/ImKcat/CatCrypto) and [argon2kt](https://github.com/lambdapioneer/argon2kt).

Compared to those, the code I've written is short. I would like to express my gratitude to them and all contributors.
