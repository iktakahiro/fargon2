import 'dart:async';

import 'package:fargon2/fargon2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}) : super();

  @override
  createState() => _MyAppState();
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
      final hash = await const Fargon2(mode: Fargon2Mode.argon2id).hash(
        passphrase: 'mypassphrase',
        salt: 'mysalt01',
        hashLength: 16,
      );
      if (mounted) {
        setState(() {
          _argon2idHash = hash;
        });
      }
    } catch (e) {
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
