import 'package:edge_notes/database/notes/notes_table.dart';

class NotesModel {
  final int id;
  final String title;
  final String description;
  final NotePriority priority;
  final DateTime time;

  NotesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.time,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotesModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        time.hashCode;
  }
}
