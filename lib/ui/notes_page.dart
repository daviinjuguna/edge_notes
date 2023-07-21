import 'package:auto_route/auto_route.dart';
import 'package:edge_notes/bloc/note_actor/note_actor_cubit.dart';
import 'package:edge_notes/bloc/note_watcher/note_watcher_bloc.dart';
import 'package:edge_notes/bloc/theme/theme_cubit.dart';
import 'package:edge_notes/database/notes/notes_table.dart';
import 'package:edge_notes/routes/app_router.dart';
import 'package:edge_notes/utils/radio_cell.dart';
import 'package:edge_notes/widgets/retry_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage(name: "NotesListRoute")
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  NoteWatcherBloc get _noteWatcherBloc => context.read();
  NoteActorCubit get _noteActorCubit => context.read();
  @override
  void initState() {
    super.initState();
    _noteWatcherBloc.add(WatchAllNotes());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              // theme
              showModalBottomSheet(
                context: context,
                builder: (builder) => BlocConsumer<ThemeCubit, ThemeState>(
                  listener: (context, state) => Navigator.of(context).pop(),
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioCell<ThemeState>(
                          title: "System",
                          groupValue: state,
                          value: ThemeState.system,
                          onChanged: (value) =>
                              context.read<ThemeCubit>().theme = value,
                        ),
                        RadioCell<ThemeState>(
                          title: "Light",
                          groupValue: state,
                          value: ThemeState.light,
                          onChanged: (value) =>
                              context.read<ThemeCubit>().theme = value,
                        ),
                        RadioCell<ThemeState>(
                          title: "Dark",
                          groupValue: state,
                          value: ThemeState.dark,
                          onChanged: (value) =>
                              context.read<ThemeCubit>().theme = value,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
        builder: (context, state) {
          switch (state.status) {
            case NoteWatcherStatus.initial:
            case NoteWatcherStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case NoteWatcherStatus.failure:
              return RetryButton(
                retry: () => _noteWatcherBloc.add(WatchAllNotes()),
              );
            default:
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return ListTile(
                      leading: Icon(
                        Icons.play_circle_outline_outlined,
                        color: _priorityToColor(note.priority),
                        size: 50,
                      ),
                      title: Text(
                        note.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(DateFormat.yMMMEd().format(note.time)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => context.navigateTo(
                              NotesDetailRoute(
                                id: note.id.toString(),
                                notes: note,
                              ),
                            ),
                            icon: Icon(Icons.edit_outlined),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          IconButton(
                            onPressed: () async {
                              final del = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Delete"),
                                  content: Text(
                                      "Are you sure you want to delete this note?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(false),
                                      child: Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(true),
                                      child: Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                              if (del ?? false) {
                                _noteActorCubit.deleteNotes(note.id);
                              }
                            },
                            color: Theme.of(context).colorScheme.error,
                            icon: Icon(Icons.delete_outline_outlined),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              FilledButton.tonal(
                onPressed: () => context.navigateTo(NotesDetailRoute()),
                child: Text("Add Note"),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _priorityToString(NotePriority priority) {
  switch (priority) {
    case NotePriority.low:
      return "Low";
    case NotePriority.medium:
      return "Medium";
    case NotePriority.high:
      return "High";
  }
}

Color _priorityToColor(NotePriority priority) {
  switch (priority) {
    case NotePriority.low:
      return Color(0xff35E968);
    case NotePriority.medium:
      return Color(0xffF68115);
    case NotePriority.high:
      return Color(0xffF24545);
  }
}
