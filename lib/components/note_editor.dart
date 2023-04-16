import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:memo/constants/sizes.dart';

class NoteEditor extends StatelessWidget {
  final FocusNode focusNode;
  final QuillController controller;
  final bool readonly;

  const NoteEditor(
      {super.key,
      required this.focusNode,
      required this.controller,
      bool? readonly})
      : readonly = readonly ?? false;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      focusNode: focusNode,
      controller: controller,
      scrollController: ScrollController(),
      scrollable: true,
      autoFocus: false,
      readOnly: readonly,
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
