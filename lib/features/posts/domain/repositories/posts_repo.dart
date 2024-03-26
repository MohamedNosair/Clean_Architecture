import 'package:dartz/dartz.dart';
import 'package:ui_design/features/posts/domain/entities/post_entities.dart';

import '../../../../core/errors/failure.dart';

abstract class PostRepository{
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
}