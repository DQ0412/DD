import 'package:app/models/topic.dart';
import 'package:app/models/topic_service.dart';
import 'package:app/models/vocabulary.dart';
import 'package:app/screens/admin/create_topic_screen.dart';
import 'package:app/screens/admin/import_export_screen.dart';
import 'package:app/screens/admin/privacy_mode_screen.dart';
import 'package:app/screens/admin/starred_vocabulary_screen.dart';
import 'package:app/screens/admin/statistics_screen.dart';
import 'package:app/screens/admin/view_topics_screen.dart';
import 'package:app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/reusable_widgets/reusable_widget.dart';


class HomeAdminScreen extends StatefulWidget {
  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final _topicService = TopicService();
  List<Topic> _topics = [];

  Future<void> _viewTopics() async {
    List<Topic> topics = await _topicService.getTopics();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewTopicsScreen(topics: topics),
      ),
    );
  }

  Future<void> _createTopic() async {
    Topic topic = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTopicScreen()),
    );
    if (topic != null) {
      setState(() {
        _topics.add(topic);
      });
    }
  }

  Future<void> _importExportVocabulary() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImportExportScreen()),
    );
    if (result != null) {
      // Refresh the topics list
      setState(() {
        _topics = [];
      });
      _viewTopics();
    }
  }

  Future<void> _setPrivacyMode(Topic topic) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacyModeScreen(topic: topic),
      ),
    );
    if (result != null) {
      // Refresh the topics list
      setState(() {
        _topics = [];
      });
      _viewTopics();
    }
  }

  Future<void> _viewStatistics(Topic topic) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatisticsScreen(topic: topic),
      ),
    );
  }

  Future<void> _viewStarredVocabulary() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StarredVocabularyScreen(starredVocabularies: [],)),
    );
  }

  Future<void> _deleteTopicOrFolder(String id) async {
    bool result = await _topicService.deleteTopicOrFolder(id);
    if (result) {
      // Refresh the topics list
      setState(() {
        _topics = [];
      });
      _viewTopics();
    }
  }

  @override
  void initState() {
    super.initState();
    _viewTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeAdminBody(
        topics: _topics,
        viewTopics: _viewTopics,
        createTopic: _createTopic,
        importExportVocabulary: _importExportVocabulary,
        setPrivacyMode: _setPrivacyMode,
        viewStatistics: _viewStatistics,
        viewStarredVocabulary: _viewStarredVocabulary,
        deleteTopicOrFolder: _deleteTopicOrFolder,
      ),
    );
  }
}

class _HomeAdminBody extends StatelessWidget {
  final List<Topic> topics;
  final Future<void> Function() viewTopics;
  final Future<void> Function() createTopic;
  final Future<void> Function() importExportVocabulary;
  final Future<void> Function(Topic topic) setPrivacyMode;
  final Future<void> Function(Topic topic) viewStatistics;
  final Future<void> Function() viewStarredVocabulary;
  final Future<void> Function(String id) deleteTopicOrFolder;

  const _HomeAdminBody({
    Key? key,
    required this.topics,
    required this.viewTopics,
    required this.createTopic,
    required this.importExportVocabulary,
    required this.setPrivacyMode,
    required this.viewStatistics,
    required this.viewStarredVocabulary,
    required this.deleteTopicOrFolder,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  Widget FirebaseUIButton(String text, void Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(text),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).size.height * 0.15,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              reusableTextField(
                "Search Topics",
                Icons.search,
                false,
                TextEditingController(),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  firebaseUIButton(
                    context,
                    "View Topics",
                    () {
                      viewTopics();
                    },
                  ),
                  firebaseUIButton(
                    context,
                    "Create Topic",
                    () {
                      createTopic();
                    },
                  ),
                  firebaseUIButton(
                    context,
                    "Import/Export",
                    () {
                      importExportVocabulary();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  for (Topic topic in topics)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              topic.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                setPrivacyMode(topic);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            firebaseUIButton(
                              context,
                              "View Statistics",
                              () {
                                viewStatistics(topic);
                              },
                            ),
                            firebaseUIButton(
                              context,
                              "Starred Vocabulary",
                              () {
                                viewStarredVocabulary();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteTopicOrFolder(topic.id);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (Vocabulary vocabulary in topic.vocabularies)
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.volume_up),
                                    onPressed: () {
                                      // Add code to play the pronunciation of the vocabulary word
                                    },
                                  ),
                                  Text(
                                    vocabulary.word,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    vocabulary.definition,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.star),
                                        onPressed: () {
                                          // Add code to star the vocabulary word
                                        },
                                      ),
                                      Text(
                                        vocabulary.status,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}