import 'package:flutter/material.dart';
import 'package:memo/constants/sizes.dart';

class NoteEmpty extends StatelessWidget {
  const NoteEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.size52),
      child: Center(
        child: Text(
          '첫 번째 메모를 작성해 보세요!',
          style: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
