import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_service.dart';

class UserManager {
  static Map<String, dynamic>? _cachedUser;
  static String? _cachedUserId;
  
  // Get user ID from SharedPreferences
  static Future<String?> getUserId() async {
    if (_cachedUserId != null) return _cachedUserId;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      _cachedUserId = prefs.getString('user_id');
      return _cachedUserId;
    } catch (e) {
      print('Error getting user ID: $e');
      return null;
    }
  }
  
  // Get full user data (cached or fetched)
  static Future<Map<String, dynamic>?> getUser() async {
    if (_cachedUser != null) return _cachedUser;
    
    final userId = await getUserId();
    if (userId == null || userId.isEmpty) return null;
    
    try {
      _cachedUser = await UserService.getById(userId);
      return _cachedUser;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
  
  // Get just the username (most common use case)
  static Future<String> getUsername() async {
    final user = await getUser();
    return user?['name'] ?? 'User';
  }
  
  // Get user email
  static Future<String> getUserEmail() async {
    final user = await getUser();
    return user?['email'] ?? '';
  }
  
  // Store user data after login/registration
  static Future<void> setUser(Map<String, dynamic> user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Store user ID for API calls
      await prefs.setString('user_id', user['id'].toString());
      
      // Store complete user data as JSON for quick access
      await prefs.setString('user_data', json.encode(user));
      
      // Update cache
      _cachedUser = user;
      _cachedUserId = user['id'].toString();
    } catch (e) {
      print('Error storing user data: $e');
    }
  }
  
  // Update cached user data (after profile updates)
  static void updateCachedUser(Map<String, dynamic> updatedUser) {
    _cachedUser = updatedUser;
    setUser(updatedUser); // Also update SharedPreferences
  }
  
  // Clear user data on logout
  static Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      await prefs.remove('user_data');
      await prefs.remove('user'); // Clean up old format
      
      _cachedUser = null;
      _cachedUserId = null;
    } catch (e) {
      print('Error clearing user data: $e');
    }
  }
  
  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null && userId.isNotEmpty;
  }
  
  // Get social media links
  static Future<Map<String, String>> getSocialMediaLinks() async {
    final user = await getUser();
    return {
      'facebook': user?['facebook'] ?? 'https://facebook.com/indoztv',
      'youtube': user?['youtube'] ?? 'https://www.youtube.com/channel/UCb2SKOElTU5sAiedbDNFMMw',
      'instagram': user?['instagram'] ?? 'https://www.instagram.com/official_indoz.tv/',
    };
  }
}
