import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edge_notes/models/notes_model.dart';
import 'package:edge_notes/repo/notes_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'single_watcher_event.dart';
part 'single_watcher_state.dart';

@injectable
class SingleWatcherBloc extends Bloc<SingleWatcherEvent, SingleWatcherState> {
  SingleWatcherBloc(this._repo) : super(SingleWatcherState()) {
    on<WatchSingleNote>((event, emit) {
      _subscription?.cancel();
      emit(state.copyWith(status: SingleWatcherStatus.loading));
      _subscription = _repo.watchSingleNotes(event.id).listen((failureOrNotes) {
        add(_ReceivedSingleNote(failureOrNotes));
      });
    });
    on<_ReceivedSingleNote>((event, emit) {
      event.failureOrNotes.fold(
        (l) => emit(state.copyWith(
          status: SingleWatcherStatus.failure,
          error: l,
        )),
        (r) => emit(state.copyWith(
          status: SingleWatcherStatus.success,
          notes: r,
        )),
      );
    });
  }

  StreamSubscription<Either<String, NotesModel?>>? _subscription;

  final NotesRepo _repo;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
