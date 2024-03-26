import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ui_design/core/errors/failure.dart';
import '../../../../../core/strings/failure.dart';
import '../../../domain/entities/post_entities.dart';
import '../../../domain/use_cases/get_all_posts.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostUseCases getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
