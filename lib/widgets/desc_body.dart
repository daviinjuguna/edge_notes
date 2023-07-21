import 'package:edge_notes/bloc/note_form/note_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescBody extends StatefulWidget {
  const DescBody({super.key});

  @override
  State<DescBody> createState() => _DescBodyState();
}

class _DescBodyState extends State<DescBody> {
  NoteFormCubit get _noteFormCubit => context.read();
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _noteFormCubit.state.item.description.value,
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
        _controller.text = state.item.description.value;
      },
      builder: (context, state) {
        return TextFormField(
          maxLines: 4,
          controller: _controller,
          onChanged: (value) => _noteFormCubit.descriptionChanged(value),
          decoration: InputDecoration(
            hintText: "Description",
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
