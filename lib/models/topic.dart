import 'dart:convert';
import 'dart:io';

import 'package:app/models/vocabulary.dart';
import 'package:path_provider/path_provider.dart';

class Topic {
  final String id;
  final String title;
  final String description;
  List<Vocabulary> vocabularies;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.vocabularies
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      vocabularies: (json['vocabularies'] as List<dynamic>).map((vocabJson) => Vocabulary.fromJson(vocabJson)).toList(),
    );
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/topics.json');
  }

  Future<void> save() async {
    final file = await _localFile;
    final topics = await loadTopics();
    topics.add(this);
    final jsonString = jsonEncode(topics);
    await file.writeAsString(jsonString);
  }

  Future<List<Topic>> loadTopics() async {
    final file = await _localFile;
    if (!file.existsSync()) {
      return [];
    }
    final jsonString = await file.readAsString();
    final jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Topic.fromJson(json)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'vocabularies': vocabularies.map((vocab) => vocab.toJson()).toList(),
    };
  }
}
