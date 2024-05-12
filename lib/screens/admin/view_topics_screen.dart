import 'package:flutter/material.dart';
import 'package:app/models/topic.dart';
import 'package:app/reusable_widgets/reusable_widget.dart';

class ViewTopicsScreen extends StatefulWidget {
  final List<Topic> topics;

  ViewTopicsScreen({required this.topics});

  @override
  _ViewTopicsScreenState createState() => _ViewTopicsScreenState();
}

class _ViewTopicsScreenState extends State<ViewTopicsScreen> {
  late Future<List<Topic>> _topicsFuture;

  @override
  void initState() {
    super.initState();
    _topicsFuture = Future.value(widget.topics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topics'),
      ),
      body: FutureBuilder<List<Topic>>(
        future: _topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading topics'),
            );
          } else {
            final topics = snapshot.data!;
            return ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return ListTile(
                  title: Text(topic.title),
                  subtitle: Text(topic.description),
                );
              },
            );
          }
        },
      ),
    );
  }
}