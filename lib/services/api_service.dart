import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class ApiService {
  static const String apiUrl = 'https://freetestapi.com/api/v1/students';

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((student) => Student.fromJson(student)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }
}
