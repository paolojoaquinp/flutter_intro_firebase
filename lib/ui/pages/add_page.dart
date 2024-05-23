import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/domain/repository/post_repository.dart';
import 'package:provider/provider.dart';

import '../../domain/post.dart';
import '../shared/add_post_provider.dart';

class AddPage extends StatefulWidget {
  const AddPage._();

  static Widget init({Post? post}) => ChangeNotifierProvider(
    lazy: false,
    create: (context) => AddProvider(
      postRepository: context.read<PostRepository>(),
      post: post
    ),
    child: const AddPage._(),
  );

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _controllerName = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _controllerImage = TextEditingController();
  final _controllerTags = TextEditingController();

  Future<void> _loadInit() async {
    final post = context.read<AddProvider>().post;
    if(post != null) {
      _controllerName.text = post.title!;
      _controllerDescription.text = post.description!;
      _controllerImage.text = post.image!;
      _controllerTags.text = post.tags![0];
    }
  }


  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                label: Text("Titulo")
              ),
            ),
            TextField(
              controller: _controllerDescription,
              decoration: const InputDecoration(
                label: Text("Descripcion")
              ),
            ),
            TextField(
              controller: _controllerImage,
              decoration: const InputDecoration(
                label: Text("URL Image")
              ),
            ),
            TextField(
              controller: _controllerTags,
              decoration: const InputDecoration(
                label: Text("Tag")
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          final newPost = Post(
            title: _controllerName.text,
            description: _controllerDescription.text,
            image: _controllerImage.text,
            tags: [_controllerTags.text]
          );

          final result = await context.read<AddProvider>().add(newPost);
          if(mounted) Navigator.of(context).pop(result);
        },
      ),
    );
  }
}