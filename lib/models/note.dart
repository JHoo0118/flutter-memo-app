import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String id;
  @HiveField(1)
  String text;
  @HiveField(2)
  String plainText;
  @HiveField(3)
  DateTime updatedAt;

  Note({
    String? id,
    DateTime? updatedAt,
    required this.text,
    required this.plainText,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        id = id ?? const Uuid().v4();
}
