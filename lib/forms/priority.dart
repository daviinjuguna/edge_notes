import 'package:edge_notes/database/notes/notes_table.dart';
import 'package:formz/formz.dart';

class PriorityInputs extends FormzInput<NotePriority, String> {
  const PriorityInputs.pure() : super.pure(NotePriority.low);
  const PriorityInputs.dirty([NotePriority value = NotePriority.low])
      : super.dirty(value);

  @override
  String? validator(NotePriority value) {
    return null;
  }
}
