

import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/domain/repository/post_repository.dart';

import '../../domain/post.dart';

class AddProvider extends ChangeNotifier {
  AddProvider({
    required this.postRepository,
    this.post
  });

  final PostRepository postRepository;
  final Post? post;


  Future<Post> add(Post newPost) async {
    Post? result;
    if(post != null) {
      result = await postRepository.updatePost(
        newPost.copyWith(id: post!.id)
      );
    } else {
      result = await postRepository.addPost(newPost);
    }

    return result;
  }
}