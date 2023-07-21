import 'package:auto_route/auto_route.dart';
import 'package:edge_notes/bloc/note_actor/note_actor_cubit.dart';
import 'package:edge_notes/bloc/note_watcher/note_watcher_bloc.dart';
import 'package:edge_notes/di/injection.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'NotesRoute')
class NotesHolderRoute extends AutoRouter with AutoRouteAware {
  NotesHolderRoute({super.key});

  late final NoteWatcherBloc _noteWatcherBloc = getIt();
  late final NoteActorCubit _noteActorCubit = getIt();
  // late final NoteFormCubit _noteFormCubit = getIt();
  // late final SingleWatcherBloc _singleWatcherBloc = getIt();

  @override
  Widget Function(BuildContext context, Widget content)? get builder =>
      (context, content) => MultiBlocProvider(
            providers: [
              BlocProvider<NoteWatcherBloc>(
                  create: (context) => _noteWatcherBloc),
              BlocProvider<NoteActorCubit>(create: (create) => _noteActorCubit),
            ],
            child: content,
          );

  @override
  void didPop() {
    _noteWatcherBloc.close();
    _noteActorCubit.close();

    super.didPop();
  }
}
