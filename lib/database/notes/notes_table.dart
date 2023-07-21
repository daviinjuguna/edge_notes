import 'package:drift/drift.dart';

@DataClassName("NotesEntry")
class NotesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get priority => intEnum<NotePriority>()();
  DateTimeColumn get createdTime =>
      dateTime().withDefault(currentDateAndTime)();
}

enum NotePriority { low, medium, high }
