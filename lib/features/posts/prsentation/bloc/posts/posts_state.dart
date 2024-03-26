part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState{}
class LoadedPostsState extends PostsState{
  final List<Post> posts ;
  LoadedPostsState({required this.posts});
}
class ErrorPostsState extends PostsState{
  final String message ;
  ErrorPostsState({required this.message});
}