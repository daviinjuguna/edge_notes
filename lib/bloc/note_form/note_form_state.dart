part of 'note_form_cubit.dart';

@immutable
class NoteFormState {
  final NotesFormItem item;
  final bool showErrorMessages;
  final bool isEditing;
  final bool isSaving;
  final Option<Either<String, Unit>> saveFailureOrSuccessOption;

  NoteFormState._({
    required this.item,
    required this.showErrorMessages,
    required this.isEditing,
    required this.isSaving,
    required this.saveFailureOrSuccessOption,
  });

  factory NoteFormState.initial() => NoteFormState._(
        item: NotesFormItem(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteFormState &&
        other.item == item &&
        other.showErrorMessages == showErrorMessages &&
        other.isEditing == isEditing &&
        other.isSaving == isSaving &&
        other.saveFailureOrSuccessOption == saveFailureOrSuccessOption;
  }

  @override
  int get hashCode {
    return item.hashCode ^
        showErrorMessages.hashCode ^
        isEditing.hashCode ^
        isSaving.hashCode ^
        saveFailureOrSuccessOption.hashCode;
  }

  NoteFormState copyWith({
    NotesFormItem? item,
    bool? showErrorMessages,
    bool? isEditing,
    bool? isSaving,
    Option<Either<String, Unit>>? saveFailureOrSuccessOption,
  }) {
    return NoteFormState._(
      item: item ?? this.item,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isEditing: isEditing ?? this.isEditing,
      isSaving: isSaving ?? this.isSaving,
      saveFailureOrSuccessOption:
          saveFailureOrSuccessOption ?? this.saveFailureOrSuccessOption,
    );
  }
}
