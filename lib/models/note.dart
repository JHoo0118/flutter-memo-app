import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String id;
  String text;
  Note({
    required this.id,
    required this.text,
  });
}
