import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImportExportScreen extends StatefulWidget {
  @override
  _ImportExportScreenState createState() => _ImportExportScreenState();
}

class _ImportExportScreenState extends State<ImportExportScreen> {
  String _exportData = '';

  Future<void> _exportDataToFile() async {
    final String data = await rootBundle.loadString('assets/data.json');
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/data.json';
    final File file = File(path);
    await file.writeAsString(data);
    setState(() {
      _exportData = 'Data exported to $path';
    });
  }

  Future<String> _importDataFromFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/data.json';
    final File file = File(path);
    if (file.existsSync()) {
      final String data = await file.readAsString();
      return data;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import/Export'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _exportDataToFile,
            child: Text('Export Data'),
          ),
          Text(_exportData),
          ElevatedButton(
            onPressed: () async {
              final String data = await _importDataFromFile();
              if (data.isNotEmpty) {
                final json = jsonDecode(data);
                // Do something with the imported data
              }
            },
            child: Text('Import Data'),
          ),
        ],
      ),
    );
  }
}