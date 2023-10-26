import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';

class ChatbotPage extends StatefulWidget {
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  var jawaban = "";
  TextEditingController pertanyaanController =
      TextEditingController(); // Controller untuk input pertanyaan
  String apiKey =
      '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'; // Ganti dengan API Key OpenAI Anda

  void _askGPT() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer $apiKey', // Mengatur kunci API
        'Content-Type': 'application/json',
      },
    ));

    String pertanyaan =
        pertanyaanController.text; // Ambil pertanyaan dari TextField

    // Membuat data yang akan dikirim
    Map<String, dynamic> data = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "kamu adalah psikologis remaja "
          //hubungkan database
        },
        {
          "role": "user",
          "content": pertanyaan, // Menggunakan pertanyaan dari TextField
        }
      ]
    };

    try {
      Response response = await dio
          .post('https://api.openai.com/v1/chat/completions', data: data);
      setState(() {
        jawaban = response.data['choices'][0]['message']['content'];
      });
      print('respond : ${response.data.toString()}');
    } on Exception catch (e) {
      print(e);
    }
    print("submit");
  }

  void _clearAnswer() {
    setState(() {
      jawaban = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minca Chat'),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey.shade800,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // Menggunakan widget SingleChildScrollView
        padding: EdgeInsets.all(16.0), // Menambahkan padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: pertanyaanController,
              decoration: InputDecoration(labelText: 'Masukkan pertanyaan'),
            ),
            ElevatedButton(
                onPressed: () {
                  _askGPT();
                },
                child: Text("submit")),
            Divider(),
            Text("Jawaban"),
            Text(jawaban),
          ],
        ),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(),
    );
  }
}
