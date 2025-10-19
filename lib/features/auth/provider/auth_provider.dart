import 'package:biet/features/auth/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  StudentModel? _user;
  StudentModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<StudentModel> loadStudent() async {
    final String jsonStudent = await rootBundle.loadString(
      "assets/data/user.json",
    );
    final Map<String, dynamic> studentMap = json.decode(jsonStudent);
    final studentData = StudentModel.fromJson(studentMap);

    _user = studentData;
    notifyListeners();
    print(_user?.password);

    return studentData;
  }
}
