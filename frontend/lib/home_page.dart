import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/client_model.dart';
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
  final TextEditingController _controller = TextEditingController();
  Future<ClientModel>? _name;

  Future<ClientModel> createClient(String name) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/client'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return ClientModel(name: jsonEncode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<String> getClient() async {
    var url = Uri.parse('https://localhost:3000/');
    var response = await http.get(url);

    var text = jsonDecode(response.body);
    return text;
    //var jsonObject = userName.fromJson(userName['results'][0]['name']['first']);
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
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter Title'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _name = createClient(_controller.text);
                });
                //text = getClient.toString();
              },
              child: Text('Save'),
            ),
            Text(_name.toString()),
            //Text(getClient().toString()),
          ],
        ),
      ),
    );
  }
}
