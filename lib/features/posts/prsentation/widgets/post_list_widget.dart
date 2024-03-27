import 'package:flutter/material.dart';
import 'package:ui_design/features/posts/domain/entities/post_entities.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            posts[index].id.toString(),
          ),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}
