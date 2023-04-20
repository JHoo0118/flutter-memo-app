import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/components/note_editor.dart';
import 'package:memo/components/note_toolbar.dart';
import 'package:memo/constants/sizes.dart';
import 'package:memo/layout/default_layout.dart';

import 'package:memo/models/note.dart';
import 'package:memo/models/note_data.dart';

class EditingNotePage extends ConsumerStatefulWidget {
  final Note note;
  final bool isNewNote;

  const EditingNotePage({
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
  bool isChanged = false;
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

    _controller.document.changes.listen((event) {
      setState(() {
        isChanged = true;
      });
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  void loadExistingNote() {
    // final Document doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
        document: Document.fromJson(jsonDecode(widget.note.text)),
        selection: const TextSelection.collapsed(offset: 0),
        keepStyleOnNewLine: true,
      );
    });
  }

  // add new note
  void addNewNote() {
    // get text from editor
    // String text = _controller.document.toPlainText();
    String text =
        jsonEncode(_controller.document.toDelta().toJson()).toString();
    String plainText = _controller.document.toPlainText();
    ref.read(noteDataStateNotifierProvider.notifier).addNewNote(
          Note(text: text, plainText: plainText),
        );
  }

  // update existing note
  void updateNote() {
    String text =
        jsonEncode(_controller.document.toDelta().toJson()).toString();

    String plainText = _controller.document.toPlainText();
    ref
        .read(noteDataStateNotifierProvider.notifier)
        .updateNote(widget.note, text, plainText, isChanged);
  }

  void showPopupMenu(BuildContext context, QuillController controller) async {
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

  void onPressed() {
    final text = _controller.document.toPlainText();
    if (widget.isNewNote &&
        (text.isNotEmpty || text.length == 1 && text[0] != '\n')) {
      addNewNote();
    } else {
      updateNote();
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onPressed,
        ),
      ),
      bottomSheet: isKeyboardVisible
          ? NoteToolbar(controller: _controller, focusNode: _focusNode)
          : null,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(Sizes.size24),
              child: MouseRegion(
                cursor: SystemMouseCursors.text,
                child:
                    NoteEditor(focusNode: _focusNode, controller: _controller),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
