part of 'single_watcher_bloc.dart';

@immutable
class SingleWatcherState {
  final SingleWatcherStatus status;
  final NotesModel? notes;
  final String error;
  SingleWatcherState({
    this.status = SingleWatcherStatus.initial,
    this.notes,
    this.error = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleWatcherState &&
        other.status == status &&
        other.notes == notes &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ notes.hashCode ^ error.hashCode;

  SingleWatcherState copyWith({
    SingleWatcherStatus? status,
    NotesModel? notes,
    String? error,
  }) {
    return SingleWatcherState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      error: error ?? this.error,
    );
  }
}

enum SingleWatcherStatus { initial, loading, success, failure }
