import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/internal/application.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  initializeFirebase();
  runApp(const Application());
}

