import 'package:biet/features/auth/provider/auth_provider.dart';
import 'package:biet/features/auth/screen/login_page.dart';
import 'package:biet/features/main/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // We use context.watch here because we want the widget to rebuild
    // whenever the authentication state changes.
    final authProvider = context.watch<AuthProvider>();

    // While checking for an existing session, show a loading indicator.
    if (authProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If the user is authenticated, show the main app.
    // Otherwise, show the login page.
    return authProvider.isAuthenticated ? const MainPage() : const LoginPage();
  }
}
