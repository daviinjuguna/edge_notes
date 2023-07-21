import 'package:formz/formz.dart';

import 'package:edge_notes/database/notes/notes_table.dart';
import 'package:edge_notes/forms/priority.dart';
import 'package:edge_notes/forms/title.dart';

import 'description.dart';

class NotesFormItem with FormzMixin {
  final TitleInput title;
  final DescriptionInput description;
  final PriorityInputs priority;
  final int? id;

  String get validError {
    return title.error ??
        description.error ??
        priority.error ??
        "Check note form";
  }

  const NotesFormItem({
    this.title = const TitleInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.priority = const PriorityInputs.dirty(NotePriority.low),
    this.id,
  });

  NotesFormItem copyWith({
    String? title,
    String? description,
    NotePriority? priority,
  }) {
    return NotesFormItem(
      id: id,
      title: title == null ? this.title : TitleInput.dirty(title),
      description: description == null
          ? this.description
          : DescriptionInput.dirty(description),
      priority:
          priority == null ? this.priority : PriorityInputs.dirty(priority),
    );
  }

  @override
  List<FormzInput> get inputs => [title, description, priority];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotesFormItem &&
        other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.id == id;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        id.hashCode;
  }
}
