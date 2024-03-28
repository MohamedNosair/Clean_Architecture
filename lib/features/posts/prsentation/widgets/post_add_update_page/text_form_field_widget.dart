import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiline;
  final String name;
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.multiline,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? '$name  Cant be empty' : null,
        decoration: InputDecoration(hintText: '$name'),
        maxLines: multiline ? 6 : 1,
        minLines: multiline ? 6 : 1,
      ),
    );
  }
}
