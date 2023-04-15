import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:memo/constants/sizes.dart';

class NoteToolbar extends StatelessWidget {
  const NoteToolbar({
    super.key,
    required QuillController controller,
    required FocusNode focusNode,
  })  : _controller = controller,
        _focusNode = focusNode;

  final QuillController _controller;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
