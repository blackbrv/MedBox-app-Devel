import 'package:flutter/material.dart';
import 'package:medapp/pages/doctor_or_user_page.dart';
import 'package:medapp/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine App',
      theme: mAppTheme.lightTheme,
      darkTheme: mAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: pickOne(), //pickOne() //UserHomePage()
    );
  }
}
