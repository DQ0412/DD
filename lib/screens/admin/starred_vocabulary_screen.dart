import 'package:flutter/material.dart';
import 'package:app/models/vocabulary.dart';
import 'package:app/reusable_widgets/reusable_widget.dart';

class StarredVocabularyScreen extends StatefulWidget {
  final List<Vocabulary> starredVocabularies;

  StarredVocabularyScreen({required this.starredVocabularies});

  @override
  _StarredVocabularyScreenState createState() => _StarredVocabularyScreenState();
}

class _StarredVocabularyScreenState extends State<StarredVocabularyScreen> {
  late Future<List<Vocabulary>> _starredVocabulariesFuture;

  @override
  void initState() {
    super.initState();
    _starredVocabulariesFuture = Future.value(widget.starredVocabularies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starred Vocabulary'),
      ),
      body: FutureBuilder<List<Vocabulary>>(
        future: _starredVocabulariesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading starred vocabulary'),
            );
          } else {
            final starredVocabularies = snapshot.data!;
            return ListView.builder(
              itemCount: starredVocabularies.length,
              itemBuilder: (context, index) {
                final vocabulary = starredVocabularies[index];
                return ListTile(
                  title: Text(vocabulary.word),
                  subtitle: Text(vocabulary.definition),
                  trailing: IconButton(
                    icon: Icon(Icons.star),
                    onPressed: () {
                      // Handle star button press
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}