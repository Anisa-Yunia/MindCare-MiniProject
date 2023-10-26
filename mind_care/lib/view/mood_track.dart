import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MoodEntry {
  final String date;
  final String mood;
  final String note;

  MoodEntry(this.date, this.mood, this.note);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoodTrackerPage(),
    );
  }
}

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  final List<MoodEntry> moodEntries = [];

  String selectedMood = "";
  String moodNote = "";

  void _addMoodEntry() {
    final now = DateTime.now();
    final formattedDate = "${now.day}-${now.month}-${now.year}";
    final entry = MoodEntry(formattedDate, selectedMood, moodNote);
    setState(() {
      moodEntries.add(entry);
      selectedMood = "";
      moodNote = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 3,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tambah Mood Entry', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Pilih Mood',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text('Mood: '),
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedMood,
                          items: ["Senang", "Sedih", "Marah", "Tenang"]
                              .map((mood) {
                            return DropdownMenuItem<String>(
                              value: mood,
                              child: Text(mood),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMood != value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Catatan (Opsional)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Catatan (Opsional)'),
                    onChanged: (value) {
                      moodNote = value;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _addMoodEntry();
                    },
                    child: Text('Simpan Mood Entry'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: moodEntries.length,
              itemBuilder: (context, index) {
                final entry = moodEntries[index];
                return ListTile(
                  title: Text('Tanggal: ${entry.date}'),
                  subtitle: Text('Mood: ${entry.mood}\nCatatan: ${entry.note}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
