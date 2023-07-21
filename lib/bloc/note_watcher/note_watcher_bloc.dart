import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edge_notes/models/notes_model.dart';
import 'package:edge_notes/repo/notes_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  NoteWatcherBloc(this._repo) : super(NoteWatcherState()) {
    on<WatchAllNotes>((event, emit) {
      _subscription?.cancel();
      emit(state.copyWith(status: NoteWatcherStatus.loading));
      _subscription = _repo.watchNotes().listen((failureOrNotes) {
        add(_ReceivedNotes(failureOrNotes));
      });
    });
    on<_ReceivedNotes>((event, emit) {
      event.failureOrNotes.fold(
        (l) => emit(state.copyWith(
          status: NoteWatcherStatus.failure,
          error: l,
        )),
        (r) => emit(state.copyWith(
          status: NoteWatcherStatus.success,
          notes: r,
        )),
      );
    });
  }

  StreamSubscription<Either<String, List<NotesModel>>>? _subscription;
  final NotesRepo _repo;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
