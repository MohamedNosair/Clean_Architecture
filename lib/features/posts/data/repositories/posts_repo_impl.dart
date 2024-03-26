import 'package:dartz/dartz.dart';
import 'package:ui_design/core/errors/exceptions.dart';
import 'package:ui_design/core/errors/failure.dart';
import 'package:ui_design/features/posts/data/data_sources/local_data_source.dart';
import 'package:ui_design/features/posts/data/data_sources/remote_data_source.dart';
import 'package:ui_design/features/posts/data/models/post_model.dart';
import 'package:ui_design/features/posts/domain/entities/post_entities.dart';
import 'package:ui_design/features/posts/domain/repositories/posts_repo.dart';

import '../../../../core/network/network_inf.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepoImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  final PostLocaleDataSource localeDataSource;

  final NetworkInfo networkInfo;

  PostRepoImpl({
    required this.remoteDataSource,
    required this.localeDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localeDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localePosts = await localeDataSource.getCachedPosts();
        return Right(localePosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage(() {
      return remoteDataSource.addPosts(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await getMessage(() {
      return remoteDataSource.deletePosts(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage(() {
      return remoteDataSource.updatePosts(postModel);
    });
  }

  Future<Either<Failure, Unit>> getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAppPost) async {
    if (await networkInfo.isConnected) {
      try {
        deleteOrUpdateOrAppPost();
        // await remoteDataSource.updatePosts(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
