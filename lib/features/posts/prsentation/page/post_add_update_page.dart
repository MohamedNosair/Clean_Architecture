import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/core/until/snack_bar.dart';
import 'package:ui_design/features/posts/domain/entities/post_entities.dart';
import 'package:ui_design/features/posts/prsentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:ui_design/features/posts/prsentation/page/posts_page.dart';
import 'package:ui_design/features/posts/prsentation/widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
      listener: (context, state) {
        if (state is MessageAddDeleteUpdatePostState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const PostsPage(),
              ),
              (route) => false);
        } else if (state is ErrorAddDeleteUpdatePostState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAddDeleteUpdatePostState) {
          const Center(child: CircularProgressIndicator());
        }
        return FormWidget(
            isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
    );
  }
}
