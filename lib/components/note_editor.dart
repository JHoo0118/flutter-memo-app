import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:memo/constants/sizes.dart';

class NoteEditor extends StatelessWidget {
  const NoteEditor({
    super.key,
    required FocusNode focusNode,
    required QuillController controller,
  })  : _focusNode = focusNode,
        _controller = controller;

  final FocusNode _focusNode;
  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
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
    );
  }
}
