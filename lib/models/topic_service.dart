import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/models/folder.dart';
import 'package:app/models/topic.dart';
import 'package:app/models/vocabulary.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

typedef Topics = List<Topic>;
typedef Folders = List<Folder>;

class TopicService {
  static const _topicsKey = 'topics';
  static const _foldersKey = 'folders';

  Future<Topics> getTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final topicsJson = prefs.getString(_topicsKey);
    if (topicsJson == null) {
      return [];
    }
    final List<dynamic> topicsList = jsonDecode(topicsJson);
    return topicsList.map((topicJson) => Topic.fromJson(topicJson)).toList();
  }

  Future<void> saveTopics(Topics topics) async {
    final prefs = await SharedPreferences.getInstance();
    final topicsJson = jsonEncode(topics.map((topic) => topic.toJson()).toList());
    await prefs.setString(_topicsKey, topicsJson);
  }

  Future<Folders> getFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final foldersJson = prefs.getString(_foldersKey);
    if (foldersJson == null) {
      return [];
    }
    final List<dynamic> foldersList = jsonDecode(foldersJson);
    return foldersList.map((folderJson) => Folder.fromJson(folderJson)).toList();
  }

  Future<void> saveFolders(Folders folders) async {
    final prefs = await SharedPreferences.getInstance();
    final foldersJson = jsonEncode(folders.map((folder) => folder.toJson()).toList());
    await prefs.setString(_foldersKey, foldersJson);
  }

  Future<String> getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  Future<void> importTopicsFromCSV(String csvData) async {
    final List<List<String>> rows = const CsvToListConverter().convert(csvData);
    final List<Topic> topics = [];
    for (int i = 1; i < rows.length; i++) {
      final List<String> row = rows[i];
      final String topicId = row[0];
      final String topicTitle = row[1];
      final String topicDescription = row[2];
      final Topic topic = Topic(
        title: topicTitle,
        description: topicDescription,
        id: topicId,
        vocabularies: [],
      );
      for (int j = 3; j < row.length; j++) {
        final String vocabularyWord = row[j];
        final String vocabularyId = DateTime.now().millisecondsSinceEpoch.toString();
        final Vocabulary vocabulary = Vocabulary(
          id: vocabularyId,
          word: vocabularyWord,
          definition: '',
          learnedCount: 0,
          memorizedCount: 0,
          totalCount: 0,
        );
        topic.vocabularies.add(vocabulary);
      }
      topics.add(topic);
    }
    final Topics currentTopics = await getTopics();
    final Topics allTopics = [...currentTopics, ...topics];
    await saveTopics(allTopics);
  }

  Future<void> exportTopicsToCSV(Topics topics) async {
    final List<List<String>> rows = [];
    for (Topic topic in topics) {
      final List<String> row = [topic.id, topic.title, topic.description];
      for (Vocabulary vocabulary in topic.vocabularies) {
        row.add(vocabulary.word);
      }
      rows.add(row);
    }
    final String csvData = const ListToCsvConverter().convert(rows);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/topics.csv';
    final File file = File(filePath);
    await file.writeAsString(csvData);
  }
  Future<bool> deleteTopicOrFolder(String id) async {
    try {
      // Call the API or database to delete the topic or folder
      final response = await http.delete(Uri.parse('https://example.com/api/topics/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete topic or folder');
      }
    } catch (e) {
      print('Error deleting topic or folder: $e');
      return false;
    }
  }
  
}