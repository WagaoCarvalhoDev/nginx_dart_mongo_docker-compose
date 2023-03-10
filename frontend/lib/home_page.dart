import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define a custom Form widget.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _HomePageState extends State<HomePage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  String text = 'Teste';

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_testValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void createClient() async {
    var url = Uri.parse('https://localhost:3000/client');
    var response = await http.get(url);
    var name = jsonDecode(response.body);
    print(name);
    //var jsonObject = userName.fromJson(userName['results'][0]['name']['first']);
  }

  void _testValue() {
    setState(() {
      text = myController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                print('First text field: $text');
              },
            ),
            ElevatedButton(
              onPressed: () {
                createClient;
              },
              child: Text(''),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
