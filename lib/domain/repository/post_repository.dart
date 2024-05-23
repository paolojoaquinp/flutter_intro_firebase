import 'package:flutter_crud_firebase/domain/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> addPost(Post post);
  Future<Post> updatePost(Post post);
  Future<bool> deletePost(String id);
}