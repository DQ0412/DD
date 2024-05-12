import 'package:app/models/topic.dart';

class Folder {
  final String id;
  final String title;
  final List<Topic> topics;

  Folder({
    required this.id,
    required this.title,
    this.topics = const [],
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'],
      title: json['title'],
      topics: List<Topic>.from(json['topics'].map((topicJson) => Topic.fromJson(topicJson))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }
}