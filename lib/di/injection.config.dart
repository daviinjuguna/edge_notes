// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:edge_notes/bloc/note_actor/note_actor_cubit.dart' as _i6;
import 'package:edge_notes/bloc/note_form/note_form_cubit.dart' as _i7;
import 'package:edge_notes/bloc/note_watcher/note_watcher_bloc.dart' as _i8;
import 'package:edge_notes/bloc/single_watcher/single_watcher_bloc.dart' as _i5;
import 'package:edge_notes/database/app_database.dart' as _i3;
import 'package:edge_notes/repo/notes_repo.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
    gh.lazySingleton<_i4.NotesRepo>(
        () => _i4.NotesRepoImp(gh<_i3.AppDatabase>()));
    gh.factory<_i5.SingleWatcherBloc>(
        () => _i5.SingleWatcherBloc(gh<_i4.NotesRepo>()));
    gh.factory<_i6.NoteActorCubit>(
        () => _i6.NoteActorCubit(gh<_i4.NotesRepo>()));
    gh.factory<_i7.NoteFormCubit>(() => _i7.NoteFormCubit(gh<_i4.NotesRepo>()));
    gh.factory<_i8.NoteWatcherBloc>(
        () => _i8.NoteWatcherBloc(gh<_i4.NotesRepo>()));
    return this;
  }
}
