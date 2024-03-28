import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/until/snack_bar.dart';
import '../../../domain/entities/post_entities.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../page/post_add_update_page.dart';
import '../../page/posts_page.dart';
import 'delete_dialog_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostAddUpdatePage(
                        isUpdatePost: true,
                        post: post,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              ElevatedButton.icon(
                onPressed: () => deleteDialog(context),
                style: const ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                icon: const Icon(Icons.delete),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PostsPage(),
                  ),
                  (route) => false);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const AlertDialog(
                title: CircularProgressIndicator(),
              );
            }
            return DeleteDialogWidget(postId: post.id!);
          },
        );
      },
    );
  }
}
