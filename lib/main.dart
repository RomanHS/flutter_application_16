import 'package:flutter/material.dart';
import 'package:flutter_application_16/app.dart';
import 'package:flutter_application_16/sl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SL.initAuthSL();
  await SL.startAuthSL();

  runApp(const App());
}
