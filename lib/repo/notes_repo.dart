import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:edge_notes/database/app_database.dart';
import 'package:edge_notes/forms/note_form.dart';
import 'package:edge_notes/models/notes_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

abstract class NotesRepo {
  //use either Future or Stream

  //Create
  Future<Either<String, Unit>> addNotes(NotesFormItem item);

  //Read
  Stream<Either<String, List<NotesModel>>> watchNotes();

  //Read single
  Stream<Either<String, NotesModel?>> watchSingleNotes(int id);

  //Update
  Future<Either<String, Unit>> updateNotes(NotesFormItem item);

  //Delete
  Future<Either<String, Unit>> deleteNotes(int id);
}

@LazySingleton(as: NotesRepo)
class NotesRepoImp implements NotesRepo {
  final AppDatabase _db;

  NotesRepoImp(this._db);
  @override
  Future<Either<String, Unit>> addNotes(NotesFormItem item) async {
    try {
      await _db.notesDao.addNotes(
        title: item.title.value,
        description: item.description.value,
        priority: item.priority.value,
      );
      return right(unit);
    } catch (e, s) {
      log("Error in addNotes", error: e, stackTrace: s);
      return left("Error in addNotes");
    }
  }

  @override
  Stream<Either<String, List<NotesModel>>> watchNotes() async* {
    yield* _db.notesDao
        .watchNotes()
        .map((event) => right<String, List<NotesModel>>(event))
        .onErrorReturnWith((e, s) {
      log("Error in watchNotes", error: e, stackTrace: s);
      return left("Error in watchNotes");
    });
  }

  @override
  Stream<Either<String, NotesModel?>> watchSingleNotes(int id) async* {
    yield* _db.notesDao
        .watchSingleNotes(id)
        .map((event) => right<String, NotesModel?>(event))
        .onErrorReturnWith((e, s) {
      log("Error in watchSingleNotes", error: e, stackTrace: s);
      return left("Error in watchSingleNotes");
    });
  }

  @override
  Future<Either<String, Unit>> updateNotes(NotesFormItem item) async {
    try {
      await _db.notesDao.updateNotes(
        id: item.id!,
        title: item.title.value,
        description: item.description.value,
        priority: item.priority.value,
      );
      return right(unit);
    } catch (e, s) {
      log("Error in updateNotes", error: e, stackTrace: s);
      return left("Error in updateNotes");
    }
  }

  @override
  Future<Either<String, Unit>> deleteNotes(int id) async {
    try {
      await _db.notesDao.deleteNotes(id);
      return right(unit);
    } catch (e, s) {
      log("Error in deleteNotes", error: e, stackTrace: s);
      return left("Error in deleteNotes");
    }
  }
}
