import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String? _baseUrl = dotenv.env["BASE_URL"];

  static final String loginUrl = '$_baseUrl/webhook/login';

  static final String getStudentUrl = '$_baseUrl/webhook/get-biet-student';
}
