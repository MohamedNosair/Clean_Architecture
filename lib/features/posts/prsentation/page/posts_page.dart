import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/features/posts/prsentation/bloc/posts/posts_bloc.dart';
import 'package:ui_design/features/posts/prsentation/widgets/message_display_widget.dart';
import 'package:ui_design/features/posts/prsentation/widgets/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Posts'),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                color: Colors.amberAccent,
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              message: state.message,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingBtn() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
