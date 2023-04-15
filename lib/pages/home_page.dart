import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memo/components/note_empty.dart';
import 'package:memo/constants/constants.dart';
import 'package:memo/constants/sizes.dart';
import 'package:memo/layout/default_layout.dart';
import 'package:memo/models/note.dart';
import 'package:memo/models/note_data.dart';
import 'package:memo/pages/editing_note_page.dart';
import 'package:memo/theme/theme_provider.dart';
import 'package:memo/utils/my_custom_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    timeago.setLocaleMessages('ko', MyCustomMessages());
  }

  void createNewNote() {
    String id = UUID.v4();
    Note newNote = Note(
      id: id,
      text: '',
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

  void onDismissed(int index, Actions action) {
    if (action == Actions.delete) {
      // deleteNote(memo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final memoList = ref.watch(noteDataStateNotifierProvider);
    // Theme.of(context).primaryColor;
    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: createNewNote,
        elevation: 0,
        backgroundColor: Colors.grey[300],
        child: const Icon(
          Icons.add,
          color: Colors.grey,
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
          memoList.isEmpty
              ? const NoteEmpty()
              : Expanded(
                  child: ListView.separated(
                    itemCount: memoList.length,
                    itemBuilder: (context, index) {
                      final memo = memoList[index];
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.green,
                              icon: Icons.share,
                              label: '공유',
                              onPressed: (context) =>
                                  onDismissed(index, Actions.share),
                            ),
                            SlidableAction(
                              backgroundColor: Colors.blue,
                              icon: Icons.archive,
                              label: '아카이브',
                              onPressed: (context) =>
                                  onDismissed(index, Actions.archive),
                            ),
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
                                    onDismissed(index, Actions.delete)),
                          ],
                        ),
                        child: ListTile(
                          leading: Text(
                            timeago.format(
                              memo.updatedAt,
                              locale: 'ko',
                            ),
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Pallete.placeholderColor
                                  : Pallete.darkColor,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size16,
                            vertical: Sizes.size16,
                          ),
                          title: Text(
                            memo.text,
                            maxLines: 3,
                          ),
                          minLeadingWidth: 60,
                          onTap: () => goToNotePage(memo, false),
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(themeStateNotifierProvider.notifier).toggleTheme();
              },
              child: const Text('테마'),
            ),
          ),
        ],
      ),
    );
  }
}
