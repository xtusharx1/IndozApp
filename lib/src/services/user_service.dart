import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserUpdateResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? user;

  UserUpdateResult({required this.success, required this.message, this.user});
}

class UserService {
  static Future<Map<String, dynamic>?> getById(String id) async {
    try {
      final url = Uri.parse('http://ec2-13-238-255-87.ap-southeast-2.compute.amazonaws.com:3000/api/user/$id');
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          return data['user'] as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print('Error fetching user by ID: $e');
    }
    return null;
  }

  static Future<UserUpdateResult> updateUser({
    required String id,
    String? name,
    String? email,
    String? currentPassword,
    String? newPassword,
  }) async {
    try {
      final url = Uri.parse('${Constants.apiBase}/api/user/$id');
      final body = {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (currentPassword != null) 'currentPassword': currentPassword,
        if (newPassword != null) 'newPassword': newPassword,
      };

      print('[Profile Update] API: PUT ' + url.toString());
      print('[Profile Update] Body: ' + body.toString());

      final resp = await http.put(
        url,
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      print('[Profile Update] Response: ${resp.statusCode} ${resp.body}');

      final data = json.decode(resp.body) as Map<String, dynamic>;

      if (resp.statusCode == 200 && data['success'] == true) {
        return UserUpdateResult(
          success: true,
          message: 'Profile updated successfully',
          user: data['user'] as Map<String, dynamic>,
        );
      }

      return UserUpdateResult(
        success: false,
        message: data['message'] as String? ?? 'Failed to update profile',
      );
    } catch (e) {
      print('[Profile Update] Exception: $e');
      return UserUpdateResult(
        success: false,
        message: 'An error occurred while updating profile',
      );
    }
  }
}
