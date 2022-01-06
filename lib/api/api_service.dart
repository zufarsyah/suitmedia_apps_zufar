import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suitmedia_apps_zufar/model/people.dart';

class ApiService {
  Future<People> topHeadlines(int data) async {
    final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$data&amp;per_page=10'));
    if (response.statusCode == 200) {
      return People.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
