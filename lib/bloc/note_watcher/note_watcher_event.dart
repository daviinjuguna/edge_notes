part of 'note_watcher_bloc.dart';

@immutable
abstract class NoteWatcherEvent {}

class WatchAllNotes extends NoteWatcherEvent {}

class _ReceivedNotes extends NoteWatcherEvent {
  final Either<String, List<NotesModel>> failureOrNotes;

  _ReceivedNotes(this.failureOrNotes);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceivedNotes && other.failureOrNotes == failureOrNotes;
  }

  @override
  int get hashCode => failureOrNotes.hashCode;
}
