part of 'single_watcher_bloc.dart';

@immutable
abstract class SingleWatcherEvent {}

class WatchSingleNote extends SingleWatcherEvent {
  final int id;

  WatchSingleNote(this.id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WatchSingleNote && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _ReceivedSingleNote extends SingleWatcherEvent {
  final Either<String, NotesModel?> failureOrNotes;

  _ReceivedSingleNote(this.failureOrNotes);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceivedSingleNote &&
        other.failureOrNotes == failureOrNotes;
  }

  @override
  int get hashCode => failureOrNotes.hashCode;
}
