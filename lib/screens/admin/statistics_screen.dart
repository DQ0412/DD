import 'package:app/models/topic.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  final Topic topic;

  StatisticsScreen({required this.topic});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // Replace this with actual data from your app
  List<String> _data = ['Metric 1', 'Metric 2', 'Metric 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.topic.title} Statistics'),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to a more detailed view of this metric
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(widget.topic, _data[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Topic _topic;
  final String _metric;

  DetailScreen(this._topic, this._metric);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_topic.title} - ${_metric} Detail'),
      ),
      body: Center(
        child: Text('This is the detail view for ${_topic.title} - ${_metric}'),
      ),
    );
  }
}