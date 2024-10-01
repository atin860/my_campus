import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_campus/Controller/model.dart';
import 'package:http/http.dart' as http;
class ApiScreen extends StatelessWidget {
  const ApiScreen({super.key});
Future<List<Model>> fetchModels() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((model) => Model.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load models');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Example')),
      body: FutureBuilder<List<Model>>(
        future: fetchModels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final models = snapshot.data!;
            return ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(models[index].title ?? 'No Title',style: TextStyle(color: Colors.red),),
                      subtitle: Text(models[index].body ?? 'No Body',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );}
}