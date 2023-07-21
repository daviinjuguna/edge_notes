import 'package:drift/drift.dart';
import 'package:edge_notes/database/app_database.dart';
import 'package:edge_notes/database/notes/notes_table.dart';
import 'package:edge_notes/models/notes_model.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [NotesTable])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(super.attachedDatabase);

  //*crud function

  //Create
  Future<void> addNotes({
    required NotePriority priority,
    required String title,
    required String description,
  }) =>
      into(notesTable).insertOnConflictUpdate(NotesTableCompanion.insert(
        title: title,
        description: description,
        priority: priority,
      ));

  //Read
  Stream<List<NotesModel>> watchNotes() => (select(notesTable)
        ..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.priority, mode: OrderingMode.desc),
        ]))
      .watch()
      .map((event) => event
          .map((e) => NotesModel(
                id: e.id,
                title: e.title,
                description: e.description,
                priority: e.priority,
                time: e.createdTime,
              ))
          .toList());

  //Read single
  Stream<NotesModel?> watchSingleNotes(int id) =>
      (select(notesTable)..where((tbl) => tbl.id.equals(id)))
          .watchSingleOrNull()
          .map((event) => event == null
              ? null
              : NotesModel(
                  id: event.id,
                  title: event.title,
                  description: event.description,
                  priority: event.priority,
                  time: event.createdTime,
                ));

  //Update
  Future<void> updateNotes({
    required int id,
    NotePriority? priority,
    String? title,
    String? description,
  }) =>
      (update(notesTable)..where((tbl) => tbl.id.equals(id))).write(
        NotesTableCompanion(
          priority: priority != null ? Value(priority) : Value.absent(),
          title: title != null ? Value(title) : Value.absent(),
          description:
              description != null ? Value(description) : Value.absent(),
        ),
      );

  //Delete
  Future<void> deleteNotes(int id) =>
      (delete(notesTable)..where((tbl) => tbl.id.equals(id))).go();
}
