import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edge_notes/database/notes/notes_table.dart';
import 'package:edge_notes/forms/note_form.dart';
import 'package:edge_notes/repo/notes_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'note_form_state.dart';

@injectable
class NoteFormCubit extends Cubit<NoteFormState> {
  NoteFormCubit(this._repo) : super(NoteFormState.initial());

  final NotesRepo _repo;

  Future<void> initialize(Option<NotesFormItem> initOption) async {
    emit(state.copyWith(
      item: initOption.getOrElse(() => NotesFormItem()),
      isEditing: initOption.isSome(),
      saveFailureOrSuccessOption: none(),
    ));
  }

  Future<void> titleChanged(String title) async {
    emit(state.copyWith(
      item: state.item.copyWith(
        title: title,
      ),
      saveFailureOrSuccessOption: none(),
    ));
  }

  Future<void> descriptionChanged(String description) async {
    emit(state.copyWith(
      item: state.item.copyWith(
        description: description,
      ),
      saveFailureOrSuccessOption: none(),
    ));
  }

  Future<void> priorityChanged(NotePriority priority) async {
    emit(state.copyWith(
      item: state.item.copyWith(
        priority: priority,
      ),
      saveFailureOrSuccessOption: none(),
    ));
  }

  Future<void> onSave() async {
    Either<String, Unit> failureOrSuccess;
    emit(state.copyWith(isSaving: true, saveFailureOrSuccessOption: none()));
    if (state.item.isValid) {
      failureOrSuccess = state.isEditing
          ? await _repo.updateNotes(state.item)
          : await _repo.addNotes(state.item);
    } else {
      failureOrSuccess = left(state.item.validError);
    }
    emit(
      state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        saveFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
