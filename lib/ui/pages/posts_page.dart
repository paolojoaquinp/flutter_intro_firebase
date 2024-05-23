import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/domain/repository/post_repository.dart';
import 'package:provider/provider.dart';

import '../shared/list_post.dart';
import 'add_page.dart';

class PostsPage extends StatefulWidget {
  const PostsPage._();

  static Widget init() => ChangeNotifierProvider(
    lazy: false,
    create: (context) => ListPost(
      postRepository: context.read<PostRepository>()
    )..load(),
    child: const PostsPage._(),
  );

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListPost>();
    final posts = provider.posts;

    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Posts")),
      body: (posts == null)
      ? const Center(child: CircularProgressIndicator(),)
      : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final elem = posts[index];
          return ListTile(
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  /* Page para actualizar */
                  builder: (_) => AddPage.init(post: elem),
                )
              );
            },
            onLongPress: () {
              context.read<ListPost>().delete(elem.id!);
            },
            title: Text(elem.title!),
            subtitle: Text(elem.tags![0]),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddPage.init()
            )
          );
        },
      ),
    );
  }
}