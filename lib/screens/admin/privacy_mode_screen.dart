import 'package:app/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyModeScreen extends StatefulWidget {
  final Topic topic;

  PrivacyModeScreen({required this.topic});

  @override
  _PrivacyModeScreenState createState() => _PrivacyModeScreenState();
}

class _PrivacyModeScreenState extends State<PrivacyModeScreen> {
  bool _isPrivacyModeEnabled = false;

  void _togglePrivacyMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPrivacyModeEnabled = value;
      prefs.setBool('isPrivacyModeEnabled', value);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPrivacyModeState();
  }

  Future<void> _loadPrivacyModeState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPrivacyModeEnabled = prefs.getBool('isPrivacyModeEnabled') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Mode for ${widget.topic.title}'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text('Enable Privacy Mode for ${widget.topic.title}'),
          value: _isPrivacyModeEnabled,
          onChanged: _togglePrivacyMode,
        ),
      ),
    );
  }
}