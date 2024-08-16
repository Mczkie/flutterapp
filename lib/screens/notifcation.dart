import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  final TextEditingController _textEditingController = TextEditingController();
  late Box<String> _notesBox;

  @override
  void initState() {
    super.initState();
    _notesBox = Hive.box<String>('notesBox');
  }

  void _addNote() {
    String note = _textEditingController.text;
    if (note.isNotEmpty) {
      _notesBox.add(note);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter you note here',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNote,
              child: const Text('Add Note'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _notesBox.listenable(),
                builder: (context, Box<String> box, _) {
                  if (box.values.isEmpty) {
                    return const Center(
                      child: Text('No notes yet'),
                    );
                  }
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final note = box.getAt(index);
                      return Card(
                        child: ListTile(
                          title: Text(note!),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              box.deleteAt(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
