import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fargon2/fargon2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _argon2idHash = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      final hash = await Fargon2(mode: Fargon2Mode.argon2id).hash(
        passphrase: 'mypassphrase',
        salt: 'mysalt01',
        hashLength: 16,
      );
      print(hash);

      if (mounted) {
        setState(() {
          _argon2idHash = hash;
        });
      }
    } catch (e) {
      print(e);
      _argon2idHash = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('hash: $_argon2idHash'),
        ),
      ),
    );
  }
}
