import 'package:flutter/material.dart';
import 'package:translator_x/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator X',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Translator"),
            SizedBox(width: 12),
            Icon(Icons.translate_rounded),
          ],
        ),
        centerTitle: true,
      ),
      body: const TranslatorForm(),
    );
  }
}
