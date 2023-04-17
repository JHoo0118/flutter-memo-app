import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:memo/components/note_empty.dart';
import 'package:memo/components/note_list_item.dart';
import 'package:memo/layout/default_layout.dart';
import 'package:memo/models/note.dart';
import 'package:memo/models/note_data.dart';
import 'package:memo/pages/editing_note_page.dart';
import 'package:memo/theme/theme_provider.dart';
import 'package:share_plus/share_plus.dart';

enum Actions { share, delete, archive }

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void createNewNote() {
    Note newNote = Note(
      text: jsonEncode([
        {"insert": "\n"}
      ]),
      plainText: '',
    );

    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  void deleteNote(Note note) {
    ref.watch(noteDataStateNotifierProvider.notifier).deleteNode(note);
  }

  void onDismissed(Note note, Actions action) {
    if (action == Actions.delete) {
      deleteNote(note);
    } else if (action == Actions.share) {
      Share.share(note.plainText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteList = ref.watch(noteDataStateNotifierProvider);
    // Theme.of(context).primaryColor;
    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: createNewNote,
        elevation: 5,
        backgroundColor: Pallete.primaryColor,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '메모',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Pallete.whiteColor
                : Pallete.blackColor,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          noteList.isEmpty
              ? const NoteEmpty()
              : Expanded(
                  child: ListView.separated(
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      final note = noteList[index];
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.green,
                              icon: Icons.share,
                              label: '공유',
                              onPressed: (context) =>
                                  onDismissed(note, Actions.share),
                            ),
                            // SlidableAction(
                            //   backgroundColor: Colors.blue,
                            //   icon: Icons.archive,
                            //   label: '아카이브',
                            //   onPressed: (context) =>
                            //       onDismissed(note, Actions.archive),
                            // ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: '삭제',
                              onPressed: (context) =>
                                  onDismissed(note, Actions.delete),
                            ),
                          ],
                        ),
                        child: NoteListItem(
                          note: note,
                          goToNotePage: () => goToNotePage(note, false),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Pallete.darkColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       ref.read(themeStateNotifierProvider.notifier).toggleTheme();
          //     },
          //     child: const Text('테마'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
