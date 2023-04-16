import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:memo/constants/sizes.dart';
import 'package:memo/models/note.dart';
import 'package:memo/theme/theme_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoteListItem extends StatelessWidget {
  const NoteListItem({
    Key? key,
    required this.note,
    required this.goToNotePage,
  }) : super(key: key);

  final Note note;
  final VoidCallback goToNotePage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        timeago.format(
          note.updatedAt,
          locale: 'ko',
        ),
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Pallete.placeholderColor
              : Pallete.darkColor,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size16,
        vertical: Sizes.size16,
      ),
      title: QuillEditor.basic(
        controller: QuillController(
          document: Document.fromJson(jsonDecode(note.text)),
          selection: const TextSelection.collapsed(offset: 0),
        ),
        readOnly: true,
      ),
      minLeadingWidth: 60,
      onTap: goToNotePage,
    );
  }
}
