import 'package:biet/features/auth/provider/auth_provider.dart';
import 'package:biet/features/main/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..loadStudent(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: "AnekDevanagari",
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
