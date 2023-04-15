import 'package:memo/data/hive_database.dart';
import 'package:memo/models/note.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_data.g.dart';

@Riverpod(keepAlive: true)
class NoteDataStateNotifier extends _$NoteDataStateNotifier {
  // hive datebase()
  final db = HiveDatabase();

  @override
  List<Note> build() {
    return initializeNotes();
  }

  initializeNotes() {
    return db.loadNotes();
  }

  // get notes
  List<Note> getAllNotes() {
    _sortByUpdateAt(state);
    return state;
  }

  // add a new note
  void addNewNote(Note note) {
    state = [note, ...state];
  }

  // update note
  void updateNote(Note note, String text, bool isChanged) {
    final List<Note> updatedList = [];
    for (int i = 0; i < state.length; i++) {
      if (state[i].id == note.id && isChanged) {
        final tempNote = state[i];
        tempNote.text = text;
        tempNote.updatedAt = DateTime.now();
        updatedList.add(tempNote);
      } else {
        updatedList.add(state[i]);
      }
    }
    _sortByUpdateAt(updatedList);
  }

  // delete note
  void deleteNode(Note note) {
    state = [...state.where((element) => element.id != note.id)];
  }

  void _sortByUpdateAt(List<Note> noteList) {
    state = noteList
      ..sort((noteA, noteB) => noteB.updatedAt.compareTo(noteA.updatedAt));
  }
}
