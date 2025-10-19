import 'package:biet/features/auth/model/student_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:biet/api/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  StudentModel? _user;
  StudentModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isAuthenticated => _user != null;

  static const String _userSessionKey = 'user_session';

  Future<bool> loginStudent({
    required String studentId,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.loginUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"studentId": studentId, "password": password}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final studentData = StudentModel.fromJson(responseBody);
        if (studentData.studentId != null &&
            studentData.studentId!.isNotEmpty) {
          _user = studentData;
          // Save session to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final userJson = jsonEncode(responseBody);
          await prefs.setString(_userSessionKey, userJson);
          return true;
        }
      }
      // If status code is not 200 or validation fails, clear user and return false
      _user = null;
      // If status code is not 200 or validation fails, return false
      return false;
    } catch (e) {
      print("Error occured during login $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refreshes the current user's data from the server.
  Future<void> refreshStudentData() async {
    // Only refresh if a user is already logged in.
    if (_user == null || _user!.studentId == null) {
      return;
    }

    try {
      // We need a way to get the password. For now, we assume a refresh endpoint
      // might exist that uses a token, or we re-use the login.
      // This example re-uses login, which is not ideal but works for now.
      // A better approach would be an endpoint that takes the studentId and returns fresh data.
      final response = await http.post(
        Uri.parse(ApiEndpoints.loginUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "studentId": _user!.studentId,
          "password": "webcap",
        }), // NOTE: Password is hardcoded here.
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final studentData = StudentModel.fromJson(responseBody);
        if (studentData.studentId != null &&
            studentData.studentId!.isNotEmpty) {
          _user = studentData;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_userSessionKey, jsonEncode(responseBody));
          notifyListeners(); // Update all listening widgets with new data.
        }
      }
    } catch (e) {
      print("Error refreshing student data: $e");
    }
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userSessionKey);
    notifyListeners();
  }

  /// Tries to log in the user from a saved session in SharedPreferences.
  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_userSessionKey)) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final extractedUserData = prefs.getString(_userSessionKey)!;
      final userMap = jsonDecode(extractedUserData) as Map<String, dynamic>;
      final studentData = StudentModel.fromJson(userMap);

      if (studentData.studentId != null && studentData.studentId!.isNotEmpty) {
        _user = studentData;
      } else {
        // Data is invalid, clear it
        await prefs.remove(_userSessionKey);
      }
    } catch (e) {
      print("Auto-login failed: $e");
      await prefs.remove(_userSessionKey); // Clear corrupted data
    }
    _isLoading = false;
    notifyListeners();
  }
}
