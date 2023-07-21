part of 'note_watcher_bloc.dart';

@immutable
class NoteWatcherState {
  final NoteWatcherStatus status;
  final List<NotesModel> notes;
  final String error;
  NoteWatcherState({
    this.status = NoteWatcherStatus.initial,
    this.notes = const [],
    this.error = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteWatcherState &&
        other.status == status &&
        listEquals(other.notes, notes) &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ notes.hashCode ^ error.hashCode;

  NoteWatcherState copyWith({
    NoteWatcherStatus? status,
    List<NotesModel>? notes,
    String? error,
  }) {
    return NoteWatcherState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      error: error ?? this.error,
    );
  }
}

enum NoteWatcherStatus { initial, loading, success, failure }
