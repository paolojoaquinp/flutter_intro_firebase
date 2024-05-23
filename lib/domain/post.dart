// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    String? id;
    String? title;
    String? description;
    String? image;
    List<String>? tags;
    DateTime? created;

    Post({
        this.id,
        this.title,
        this.description,
        this.image,
        this.tags,
        this.created,
    });

    Post copyWith({
        String? id,
        String? title,
        String? description,
        String? image,
        List<String>? tags,
        DateTime? created,
    }) => 
        Post(
            id: id ?? this.id,
            title: title ?? this.title,
            description: description ?? this.description,
            image: image ?? this.image,
            tags: tags ?? this.tags,
            created: created ?? this.created,
        );

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "created": created?.toIso8601String(),
    };
}
