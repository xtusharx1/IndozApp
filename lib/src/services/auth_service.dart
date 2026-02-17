import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('${Constants.apiBase}/api/login');
    final body = {'email': email, 'password': password};
    print('[LOGIN] API: POST ' + url.toString());
    print('[LOGIN] Body: ' + body.toString());
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    print('[LOGIN] Response: ${resp.statusCode} ${resp.body}');
    final data = json.decode(resp.body) as Map<String, dynamic>;

    if (resp.statusCode == 200 && data['success'] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', data['user']['id'].toString());
    }

    return data;
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final url = Uri.parse('${Constants.apiBase}/api/register');
    final body = {'name': name, 'email': email, 'password': password};
    print('[REGISTER] API: POST ' + url.toString());
    print('[REGISTER] Body: ' + body.toString());
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    print('[REGISTER] Response: ${resp.statusCode} ${resp.body}');
    return json.decode(resp.body) as Map<String, dynamic>;
  }
}
