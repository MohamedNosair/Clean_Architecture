import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdatePost;
  final Function() onPressed;
  const FormSubmitBtn(
      {super.key, required this.isUpdatePost, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdatePost
          ? const Icon(
              Icons.edit,
            )
          : const Icon(
              Icons.add,
            ),
      label: Text(
        isUpdatePost ? 'Edit' : 'Add',
      ),
    );
  }
}
