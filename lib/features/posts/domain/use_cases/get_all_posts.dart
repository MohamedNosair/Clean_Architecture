import 'package:dartz/dartz.dart';
import 'package:ui_design/features/posts/domain/repositories/posts_repo.dart';

import '../../../../core/errors/failure.dart';
import '../entities/post_entities.dart';

class GetAllPostUseCases {
  final PostRepository postRepository;

  GetAllPostUseCases(this.postRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postRepository.getAllPosts();
  }
}
