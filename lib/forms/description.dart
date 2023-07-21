import 'package:formz/formz.dart';

class DescriptionInput extends FormzInput<String, String> {
  const DescriptionInput.pure() : super.pure('');
  const DescriptionInput.dirty([String value = '']) : super.dirty(value);
  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'Description cannot be empty';
    }
    return null;
  }
}
