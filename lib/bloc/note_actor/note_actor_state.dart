part of 'note_actor_cubit.dart';

@immutable
class NoteActorState {
  final NoteActorStatus status;
  final String success;
  final String error;
  NoteActorState({
    this.status = NoteActorStatus.initial,
    this.success = '',
    this.error = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteActorState &&
        other.status == status &&
        other.success == success &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ success.hashCode ^ error.hashCode;

  @override
  String toString() =>
      'NoteActorState(status: $status, success: $success, error: $error)';

  NoteActorState copyWith({
    NoteActorStatus? status,
    String? success,
    String? error,
  }) {
    return NoteActorState(
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}

enum NoteActorStatus { initial, loading, success, failure }
