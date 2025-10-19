import 'package:biet/features/auth/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  StudentModel? _user;
  StudentModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isAuthenticated => _user != null;

  Future<bool> loadStudent() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String jsonStudent = await rootBundle.loadString(
        "assets/data/user.json",
      );
      final Map<String, dynamic> studentMap = json.decode(jsonStudent);
      final studentData = StudentModel.fromJson(studentMap);

      // ***VALIDATION CHECK***
      // Only consider it a successful login if we have a studentId.
      if (studentData.iId != null && studentData.studentId!.isNotEmpty) {
        _user = studentData;
        _isLoading = false;
        notifyListeners();
        return true; // Success
      }
    } catch (e) {
      // Handle potential errors during file loading or JSON parsing
      print("Error loading student data: $e");
    }

    // If validation fails or an error occurs, ensure user is not set.
    _user = null;
    _isLoading = false;
    notifyListeners();
    return false; // Failure
  }
}
