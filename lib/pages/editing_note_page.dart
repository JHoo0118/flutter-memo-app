import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/constants/constants.dart';
import 'package:memo/constants/sizes.dart';
import 'package:memo/layout/default_layout.dart';

import 'package:memo/models/note.dart';
import 'package:memo/models/note_data.dart';

class EditingNotePage extends ConsumerStatefulWidget {
  Note note;
  bool isNewNote;

  EditingNotePage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  ConsumerState<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends ConsumerState<EditingNotePage> {
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  bool isKeyboardVisible = false;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    loadExistingNote();

    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });

    // _controller.document.changes.listen((event) {
    //   var list = event.change.toList();
    //   // ignore: prefer_is_empty
    //   if (list.length >= 1) {
    //     var letter = list[1].data;
    //     if (letter == '/') {
    //       print('pop up menu');
    //       _showPopupMenu(context, _controller);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
        keepStyleOnNewLine: true,
      );
    });
  }

  // add new note
  void addNewNote() {
    // get text from editor
    String id = UUID.v4();
    String text = _controller.document.toPlainText();
    ref.read(noteDataStateNotifierProvider.notifier).addNewNote(
          Note(id: id, text: text),
        );
  }

  // update existing note
  void updateNote() {
    String text = _controller.document.toPlainText();
    ref
        .read(noteDataStateNotifierProvider.notifier)
        .updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNote();
            }
            Navigator.pop(context);
          },
        ),
      ),
      bottomSheet: isKeyboardVisible
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                child: QuillToolbar.basic(
                  toolbarIconSize: Sizes.size28,
                  controller: _controller,
                  showAlignmentButtons: true,
                  afterButtonPressed: _focusNode.requestFocus,
                  showCodeBlock: true,
                  showRedo: false,
                  showUndo: false,
                  showCenterAlignment: true,
                  showColorButton: true,
                  showDirection: false,
                  showFontFamily: false,
                  showDividers: false,
                  showIndent: false,
                  showHeaderStyle: true,
                  showLink: false,
                  showSearchButton: false,
                  showInlineCode: false,
                  showQuote: true,
                  showListNumbers: false,
                  showListBullets: false,
                  showClearFormat: false,
                  showBoldButton: true,
                  showFontSize: false,
                  showItalicButton: true,
                  showUnderLineButton: true,
                  showStrikeThrough: true,
                  showListCheck: true,
                ),
              ),
            )
          : null,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(Sizes.size24),
              child: MouseRegion(
                cursor: SystemMouseCursors.text,
                child: QuillEditor(
                  focusNode: _focusNode,
                  controller: _controller,
                  scrollController: ScrollController(),
                  scrollable: true,
                  autoFocus: false,
                  readOnly: false,
                  placeholder: '메모를 작성해 보세요!',
                  padding: EdgeInsets.zero,
                  expands: true,
                  customStyles: DefaultStyles(
                    h1: DefaultTextBlockStyle(
                      const TextStyle(
                        fontSize: Sizes.size32,
                        height: 1.15,
                        fontWeight: FontWeight.w400,
                      ),
                      const VerticalSpacing(Sizes.size16, 0),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    h2: DefaultTextBlockStyle(
                        const TextStyle(
                          fontSize: Sizes.size24,
                          height: 1.02,
                          fontWeight: FontWeight.w300,
                        ),
                        const VerticalSpacing(Sizes.size12, 0),
                        const VerticalSpacing(0, 0),
                        null),
                    h3: DefaultTextBlockStyle(
                        const TextStyle(
                          fontSize: Sizes.size20,
                          height: 0.92,
                          fontWeight: FontWeight.w300,
                        ),
                        const VerticalSpacing(Sizes.size8, 0),
                        const VerticalSpacing(0, 0),
                        null),
                    sizeSmall: const TextStyle(fontSize: Sizes.size8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showPopupMenu(BuildContext context, QuillController controller) async {
  await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(100, 100, 100, 100),
    items: [
      const PopupMenuItem(
        value: 1,
        child: Text("H1 텍스트"),
      ),
      const PopupMenuItem(
        value: 2,
        child: Text("H2 텍스트"),
      ),
      const PopupMenuItem(
        value: 3,
        child: Text("H3 텍스트"),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {
      // 메뉴 선택 함
    } else {
      // 메뉴 선택 안 함
    }
  });
}
