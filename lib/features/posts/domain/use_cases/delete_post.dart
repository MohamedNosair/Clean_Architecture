import 'package:dartz/dartz.dart';
import 'package:ui_design/features/posts/domain/repositories/posts_repo.dart';

import '../../../../core/errors/failure.dart';

class DeletePostUseCase{
  final PostRepository postRepository ;
  DeletePostUseCase(this.postRepository);
  Future<Either<Failure, Unit>> call(int postId)async{
    return await postRepository.deletePost(postId);
  }
}