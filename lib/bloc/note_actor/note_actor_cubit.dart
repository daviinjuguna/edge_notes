import 'package:bloc/bloc.dart';
import 'package:edge_notes/repo/notes_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'note_actor_state.dart';

@Injectable()
class NoteActorCubit extends Cubit<NoteActorState> {
  NoteActorCubit(this._repo) : super(NoteActorState());

  final NotesRepo _repo;

  //create

  Future<void> deleteNotes(int id) async {
    emit(state.copyWith(status: NoteActorStatus.loading));
    final result = await _repo.deleteNotes(id);
    result.fold(
      (l) => emit(state.copyWith(
        status: NoteActorStatus.failure,
        error: l,
      )),
      (r) => emit(state.copyWith(
        status: NoteActorStatus.success,
        success: "Note Deleted",
      )),
    );
  }
}
