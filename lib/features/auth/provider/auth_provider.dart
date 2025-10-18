import 'dart:convert';

import 'package:biet/features/auth/model/student_model.dart';
import 'package:flutter/services.dart';

class AuthProvider {
  Future<StudentModel> loadStudent() async {
    final String jsonStudent = await rootBundle.loadString(
      "assets/data/user.json",
    );
    final Map<String, dynamic> studentMap = json.decode(jsonStudent);
    final studentData = StudentModel.fromJson(studentMap);

    return studentData;
  }
}
