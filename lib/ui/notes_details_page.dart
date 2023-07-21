import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' show optionOf;
import 'package:edge_notes/bloc/note_form/note_form_cubit.dart';
import 'package:edge_notes/database/notes/notes_table.dart';
import 'package:edge_notes/di/injection.dart';
import 'package:edge_notes/forms/description.dart';
import 'package:edge_notes/forms/note_form.dart';
import 'package:edge_notes/forms/priority.dart';
import 'package:edge_notes/forms/title.dart';
import 'package:edge_notes/models/notes_model.dart';
import 'package:edge_notes/widgets/desc_body.dart';
import 'package:edge_notes/widgets/title_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotesDetailPage extends StatefulWidget {
  const NotesDetailPage({
    super.key,
    @PathParam('id') this.id = 'create',
    this.notes,
  });
  final String id;
  final NotesModel? notes;

  @override
  State<NotesDetailPage> createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  late final NoteFormCubit _noteFormCubit = getIt();
  // late final SingleWatcherBloc _singleWatcherBloc = getIt();
  @override
  void initState() {
    super.initState();
    // if (widget.id != 'create') {
    //   _singleWatcherBloc.add(WatchSingleNote(
    //     int.parse(widget.id),
    //   ));
    // } else {
    //   _noteFormCubit.initialize(optionOf(null));
    // }
    _noteFormCubit.initialize(
      optionOf(
        widget.notes != null
            ? NotesFormItem(
                id: int.tryParse(widget.id),
                title: TitleInput.dirty(widget.notes!.title),
                description: DescriptionInput.dirty(widget.notes!.description),
                priority: PriorityInputs.dirty(widget.notes!.priority),
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _noteFormCubit.close();
    // _singleWatcherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteFormCubit>(create: (context) => _noteFormCubit),
        // BlocProvider<SingleWatcherBloc>(
        //     create: (context) => _singleWatcherBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NoteFormCubit, NoteFormState>(
            listener: (context, state) {
              if (state.isSaving) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Saving..."),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ));
              }
              if (state.saveFailureOrSuccessOption.isSome()) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    backgroundColor: state.saveFailureOrSuccessOption.fold(
                      () => Colors.red,
                      (a) => Colors.green,
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.saveFailureOrSuccessOption.fold(
                          () => "Error",
                          (a) => "Success",
                        )),
                        Icon(
                          state.saveFailureOrSuccessOption.fold(
                            () => Icons.error,
                            (a) => Icons.check,
                          ),
                        ),
                      ],
                    ),
                  ));
                state.saveFailureOrSuccessOption
                    .fold(() => null, (a) => context.back());
              }
            },
          ),
          // BlocListener<SingleWatcherBloc, SingleWatcherState>(
          //   listener: (context, state) {
          //     switch (state.status) {
          //       case SingleWatcherStatus.success:
          //         _noteFormCubit.initialize(
          //           optionOf(
          //             state.notes != null
          //                 ? NotesFormItem(
          //                     id: state.notes!.id,
          //                     title: TitleInput.dirty(state.notes!.title),
          //                     description: DescriptionInput.dirty(
          //                         state.notes!.description),
          //                     priority:
          //                         PriorityInputs.dirty(state.notes!.priority),
          //                   )
          //                 : null,
          //           ),
          //         );
          //         break;
          //       default:
          //     }
          //   },
          // )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("Notes"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Priority"),
                    SizedBox(width: 20),
                    BlocBuilder<NoteFormCubit, NoteFormState>(
                      builder: (context, state) {
                        return DropdownButton<NotePriority>(
                          value: state.item.priority.value,
                          iconEnabledColor:
                              _priorityToColor(state.item.priority.value),
                          items: NotePriority.values
                              .map((e) => DropdownMenuItem(
                                    child: Text(_priorityToString(e)),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              _noteFormCubit.priorityChanged(value!),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 20),
                TitleBody(),
                SizedBox(height: 20),
                DescBody(),
                Spacer(),
                FilledButton.tonal(
                  onPressed: () {
                    _noteFormCubit.onSave();
                  },
                  child: Text("Submit"),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
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
