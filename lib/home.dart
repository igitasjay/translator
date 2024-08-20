import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
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

class TranslatorForm extends StatefulWidget {
  const TranslatorForm({super.key});

  @override
  TranslatorFormState createState() => TranslatorFormState();
}

class TranslatorFormState extends State<TranslatorForm> {
  final TextEditingController controller = TextEditingController();
  final GoogleTranslator translator = GoogleTranslator();

  String translateFrom = "en";
  String translateTo = "es";
  String result = "Translation result will appear here";

  void translate() async {
    try {
      final translation = await translator.translate(
        controller.text,
        from: translateFrom,
        to: translateTo,
      );
      setState(() {
        result = translation.text;
      });
    } catch (e) {
      setState(() {
        result = "Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: <Widget>[
        TextField(
          controller: TextEditingController(text: result),
          readOnly: true,
          maxLines: null,
          decoration: InputDecoration(
            label: Text(translateTo),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              value: translateFrom,
              items: const [
                DropdownMenuItem(value: "en", child: Text("English")),
                DropdownMenuItem(value: "es", child: Text("Spanish")),
                DropdownMenuItem(value: "fr", child: Text("French")),
              ],
              onChanged: (value) {
                setState(() {
                  translateFrom = value!;
                });
              },
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_right_alt_rounded),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: translateTo,
              items: const [
                DropdownMenuItem(value: "en", child: Text("English")),
                DropdownMenuItem(value: "es", child: Text("Spanish")),
                DropdownMenuItem(value: "fr", child: Text("French")),
              ],
              onChanged: (value) {
                setState(() {
                  translateTo = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            label: const Text("Enter sentence to translate"),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                translate();
              } else {
                setState(() {
                  result = "Translation result will appear here";
                });
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.all(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Translate"),
                SizedBox(width: 8),
                Icon(Icons.translate),
              ],
            ),
          ),
        ),
        Icon(
          Icons.translate,
          size: MediaQuery.of(context).size.width,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
