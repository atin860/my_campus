import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart'; // For copying to clipboard

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatBot(),
    );
  }
}

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessagesFromFirestore();
  }

  Future<void> _loadMessagesFromFirestore() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp')
        .get();

    final List<Map<String, dynamic>> loadedMessages = querySnapshot.docs.map((doc) {
      return {
        'role': doc['role'],
        'content': doc['content'],
      };
    }).toList();

    setState(() {
      messages = loadedMessages;
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).unfocus();

    String userMessage = _controller.text;

    setState(() {
      messages.add({"role": "user", "content": userMessage});
      _isLoading = true;
    });

    await _saveMessageToFirestore("user", userMessage);
    _controller.clear();

    String botResponse = await chatbot(userMessage);

    setState(() {
      messages.add({"role": "bot", "content": botResponse});
      _isLoading = false;
    });

    await _saveMessageToFirestore("bot", botResponse);
  }

  Future<void> _saveMessageToFirestore(String role, String content) async {
    await FirebaseFirestore.instance.collection('messages').add({
      'role': role,
      'content': content,
      'timestamp': Timestamp.now(),
    });
  }

  Future<String> chatbot(String message) async {
    final String apiUrl =
        "https://llama.us.gaianet.network/v1/chat/completions";

    final payload = {
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": message}
      ],
      "model": "Jarvis"
    };

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse["choices"][0]["message"]["content"];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "An error occurred";
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to clipboard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Chat with Jarvis"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isLoading && index == messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          CircularProgressIndicator(strokeWidth: 2.0),
                          SizedBox(width: 10),
                          Text(
                            'Jarvis is typing...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final message = messages[index];
                bool isUserMessage = message['role'] == 'user';

                return GestureDetector(
                  onLongPress: () => _copyToClipboard(message['content'] ?? ''),
                  child: Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        color: isUserMessage
                            ? kappbarback
                            : Colors.green[300],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        message['content'] ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: kappbarback,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
