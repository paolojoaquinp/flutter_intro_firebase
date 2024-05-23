

import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/domain/repository/post_repository.dart';

import '../../domain/post.dart';


// Provider de inyeccion de PostFirebase
class ListPost extends ChangeNotifier {

  ListPost({
    required this.postRepository
  });
  final PostRepository postRepository;

  List<Post>? posts;

  Future<void> load() async {
    posts = await postRepository.getPosts();
    notifyListeners();
  }

  void add(Post post) {
    posts?.add(post);
    notifyListeners();
  }


  // Solo para la UI
  void update(Post post) {
    final index = posts?.indexWhere((element) => element.id == post.id);
    if(index != null && index >= 0) {
      posts?[index] = post;
      notifyListeners();
    }
  }
  //

  Future<void> delete(String docId) async {
    await postRepository.deletePost(docId);
    posts?.removeWhere((element) => element.id == docId);
    notifyListeners();
  }
}