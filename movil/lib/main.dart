import 'package:flutter/material.dart';
import 'package:movil/src/Userpreferences/user_preferences.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}