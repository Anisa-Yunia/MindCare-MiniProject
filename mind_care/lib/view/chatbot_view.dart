import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String content;
  final bool isUser;

  ChatMessage(this.content, this.isUser);
}

class ChatbotPage extends StatefulWidget {
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  List<ChatMessage> messages = [];
  TextEditingController messageController = TextEditingController();
  var jawaban = "";
  String apiKey =
      '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'; // Ganti dengan API Key OpenAI Anda

  void _sendMessage(String messageText) {
    setState(() {
      messages.add(ChatMessage(
        messageText,
        true, // true berarti pesan dari pengguna
      ));
    });

    messageController.clear();
  }

  void _askGPT() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    ));

    String pertanyaan = messageController.text;

    Map<String, dynamic> data = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content":
              "kamu adalah minca,s seorang psikolog yang memiliki pengalam dibidang kesehatan mental seperti kecemasan, stress dan depresi, kamu dapat membantu mengatasi pertanyaan sederhana seperti tips dan trik, jika kamu diberi pertanyaan diluar dari topic piskologi dan kesehatan mental kamu harus menjawab bahwa itu diluar kemampuan kamu",
        },
        {
          "role": "user",
          "content": pertanyaan,
        },
      ],
      "temperature": 1,
      "max_tokens": 256,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    };

    try {
      Response response = await dio
          .post('https://api.openai.com/v1/chat/completions', data: data);
      setState(() {
        jawaban = response.data['choices'][0]['message']['content'];
        messages
            .add(ChatMessage(jawaban, false)); // false berarti pesan dari bot
      });
      print('respond : ${response.data.toString()}');
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                ChatMessage message = messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Colors.blue.shade300
                          : Colors.blueGrey.shade700,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = messageController.text;
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                      _askGPT();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
