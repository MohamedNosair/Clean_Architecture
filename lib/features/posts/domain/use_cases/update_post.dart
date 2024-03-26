import 'package:dartz/dartz.dart';
import 'package:ui_design/features/posts/domain/entities/post_entities.dart';
import 'package:ui_design/features/posts/domain/repositories/posts_repo.dart';

import '../../../../core/errors/failure.dart';

class UpdatePostUseCase{
  final PostRepository postRepository ;
  UpdatePostUseCase(this.postRepository);
  Future<Either<Failure, Unit>> call(Post post)async{
    return await postRepository.updatePost(post);
  }
}