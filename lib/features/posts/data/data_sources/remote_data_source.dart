import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ui_design/core/errors/exceptions.dart';
import 'package:ui_design/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> addPosts(PostModel postModel);

  Future<Unit> updatePosts(PostModel postModel);

  Future<Unit> deletePosts(int postId);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSource implements RemoteDataSource {
  final http.Client client;

  PostRemoteDataSource({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(BASE_URL + '/posts/'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPosts(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client.post(
      Uri.parse(BASE_URL + '/posts/'),
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePosts(int postId) async {
    final response = await client.delete(
        Uri.parse('$BASE_URL/posts/${postId.toString()}'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePosts(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client.patch(
      Uri.parse('$BASE_URL/posts/$postId'),
      body: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}