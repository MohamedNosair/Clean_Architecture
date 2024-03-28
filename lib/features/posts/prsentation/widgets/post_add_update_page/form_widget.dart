import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/features/posts/domain/entities/post_entities.dart';
import 'package:ui_design/features/posts/prsentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:ui_design/features/posts/prsentation/widgets/post_add_update_page/form_submit_btn.dart';
import 'package:ui_design/features/posts/prsentation/widgets/post_add_update_page/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              name: 'Title', multiline: false, controller: titleController),
          TextFormFieldWidget(
              name: 'Body', multiline: true, controller: bodyController),
          FormSubmitBtn(
              isUpdatePost: widget.isUpdatePost,
              onPressed: validateFormThenUpdateOrAddPost),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = formKey.currentState!.validate();
    final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: titleController.text,
        body: bodyController.text);
    if (isValid) {
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
