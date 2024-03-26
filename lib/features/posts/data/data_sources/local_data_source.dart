import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_design/core/errors/exceptions.dart';
import 'package:ui_design/features/posts/data/models/post_model.dart';

abstract class PostLocaleDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}
const CACHED_POST ='CACHED_POSTS' ;

class PostLocaleDataSourceImpl implements PostLocaleDataSource {
  final SharedPreferences sharedPreferences;

  PostLocaleDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POST, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POST);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
