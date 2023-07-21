import 'package:edge_notes/bloc/note_form/note_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TitleBody extends StatefulWidget {
  const TitleBody({super.key});

  @override
  State<TitleBody> createState() => _TitleBodyState();
}

class _TitleBodyState extends State<TitleBody> {
  NoteFormCubit get _noteFormCubit => context.read();
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _noteFormCubit.state.item.title.value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormCubit, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        _controller.text = state.item.title.value;
      },
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          onChanged: (value) => _noteFormCubit.titleChanged(value),
          decoration: InputDecoration(
            hintText: "Title",
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
