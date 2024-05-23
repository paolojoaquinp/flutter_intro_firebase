
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_firebase/domain/post.dart';
import 'package:flutter_crud_firebase/domain/repository/post_repository.dart';

class PostFirebase implements PostRepository {
  final postRef = FirebaseFirestore.instance.collection('posts')
    .withConverter(
      fromFirestore: (snapshot, _) {
        final post = Post.fromJson(snapshot.data()!);
        final newPost = post.copyWith(id: snapshot.id);
        return newPost;
      },
      toFirestore: (post, _) => post.toJson(),
    );

  @override
  Future<List<Post>> getPosts() async {
    final querySnapshot = await postRef.get();
    final posts = querySnapshot.docs.map(
      (elem) => elem.data()
    ).toList();

    return posts;
  }


  @override
  Future<Post> addPost(Post post) async {
    final result = await postRef.add(post);
    return post.copyWith(id: result.id);
  }

  @override
  Future<Post> updatePost(Post post) async {
    await postRef.doc(post.id).update(post.toJson());
    return post;
  }

  @override
  Future<bool> deletePost(String id) async {
    await postRef.doc(id).delete();
    return true;
  }
}