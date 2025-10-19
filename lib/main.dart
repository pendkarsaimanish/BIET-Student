import 'package:biet/features/auth/provider/auth_provider.dart';
import 'package:biet/features/main/provider/navigation_provider.dart';
import 'package:biet/features/auth/screen/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..tryAutoLogin(),
        ),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthGate(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: "AnekDevanagari",
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
