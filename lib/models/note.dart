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
  DateTime updatedAt;

  Note({
    String? id,
    required this.text,
    DateTime? updatedAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        id = id ?? const Uuid().v4();
}
