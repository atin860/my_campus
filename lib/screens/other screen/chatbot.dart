import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/textfield.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
 bool _isLoading = false; // Track loading state
  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
 FocusScope.of(context).unfocus(); 
    // Add user message to the list
    setState(() {
      messages.add({"role": "user", "content": _controller.text});
      _isLoading=true;
    });

    // Call the chatbot API
    String botResponse = await chatbot(_controller.text);
    setState(() {
      messages.add({"role": "bot", "content": botResponse});
      _isLoading=false;
    });

    // Clear the text field
    _controller.clear();
  }

  Future<String> chatbot(String message) async {
    final String apiUrl = "https://llama.us.gaianet.network/v1/chat/completions"; // Ensure this is correct

    // Prepare the payload
    final payload = {
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": message}
      ],
      "model": "model_name" // Replace with your actual model name
    };

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      // Send the request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(payload),
      );

      // Debugging: Print the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check if the response is successful
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse["choices"][0]["message"]["content"];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      print('Error: $e');
      return "An error occurred";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "AI CHATBOT"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isBotMessage = message["role"] == "bot";
                return Align(
                  alignment: isBotMessage ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isBotMessage ? Colors.grey.shade200 : Colors.teal.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["content"]!,
                      style: TextStyle(
                        color: isBotMessage ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: _controller,
                    label: "label", hintText: "hintText")
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
