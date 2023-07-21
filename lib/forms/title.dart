import 'package:formz/formz.dart';

class TitleInput extends FormzInput<String, String> {
  const TitleInput.pure() : super.pure('');
  const TitleInput.dirty([String value = '']) : super.dirty(value);
  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'Title cannot be empty';
    }
    return null;
  }
}
