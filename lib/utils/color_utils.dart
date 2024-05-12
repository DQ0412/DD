import 'package:flutter/material.dart';

Color hexStringToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceAll('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
