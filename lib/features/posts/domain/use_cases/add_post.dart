import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/post_entities.dart';
import '../repositories/posts_repo.dart';

class AddPostUseCase {
  final PostRepository postRepository;

  AddPostUseCase(this.postRepository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.addPost(post);
  }
}
