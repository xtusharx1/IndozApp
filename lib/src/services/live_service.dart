import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class LiveService {
  static Future<Map<String, dynamic>?> fetchLive() async {
    final url = Uri.parse('${Constants.apiBase}/api/live');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final body = json.decode(resp.body) as Map<String, dynamic>;
      if (body['success'] == true && body['live'] != null) {
        return body['live'] as Map<String, dynamic>;
      }
    }
    return null;
  }
}
