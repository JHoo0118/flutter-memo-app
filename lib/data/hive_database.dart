import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/note.dart';

class HiveDatabase {
  // reference our hive box
  Box<Note> noteList = Hive.box('note_database');
  // load notes
  List<Note> loadNotes() {
    List<Note> list = noteList.values.toList();
    // if (list.isEmpty) {
    //   Note initialNote = Note(text: r'{"insert":"hello\n"}');
    //   savedNotes(initialNote);
    //   list.add(initialNote);
    // }
    for (int i = 0; i < list.length; i++) {
      // list[i].text = jsonDecode(list[i].text);
    }
    return list;
    // List<Note> savedNotesFormatted = [];

    // if (_myBox.get("ALL_NOTES") != null) {
    //   List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
    //   for (int i = 0; i < savedNotes.length; i++) {
    //     savedNotesFormatted.add(
    //       Note(
    //         id: savedNotes[i].id,
    //         text: savedNotes[i].text,
    //         updatedAt: savedNotes[i].updatedAt,
    //       ),
    //     );
    //   }
    // } else {
    //   // default first note
    //   savedNotesFormatted.add(
    //     Note(text: r'{"insert":"hello\n"}'),
    //   );
    // }

    // return savedNotesFormatted;
  }

  // save notes
  void savedNotes(Note note) {
    noteList.put(note.id, note);
    // List<Note> allNotesFormatted = [
    //   /*
    //   [
    //     Note(),
    //     Note(),
    //     ...
    //   ]
    //   // each note has an id and text
    //   */
    // ];
    // for (var note in allNotes) {
    //   String id = note.id;
    //   String text = note.text;
    //   DateTime updatedAt = note.updatedAt;
    //   allNotesFormatted.add(Note(
    //     id: id,
    //     text: text,
    //     updatedAt: updatedAt,
    //   ));

    //   // then store into hive
    //   _myBox.put("ALL_NOTES", allNotesFormatted);
    // }
  }

  void updateNotes(Note note) {
    noteList.put(note.id, note);
  }
}
