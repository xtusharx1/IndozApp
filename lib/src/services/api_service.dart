import '../models/hire_studio_request.dart';
import '../models/ads_quote_inquiry.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/ad.dart';

class ApiService {

    Future<Map<String, dynamic>> submitHireStudioRequest(HireStudioRequest request) async {
      final url = Uri.parse('${Constants.apiBase}/api/hire-studio-request');
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
      return json.decode(resp.body) as Map<String, dynamic>;
    }

    Future<Map<String, dynamic>> submitAdsQuoteInquiry(AdsQuoteInquiry inquiry) async {
      final url = Uri.parse('${Constants.apiBase}/api/ads-quote-inquiry');
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(inquiry.toJson()),
      );
      return json.decode(resp.body) as Map<String, dynamic>;
    }
  // Placeholder methods that later will call the backend
  Future<Map<String, dynamic>> getLive() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {'is_active': false};
  }

  Future<Map<String, dynamic>> getAbout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'org_name': 'Indoz Media',
      'desc': 'Sample description',
      'email': 'contact@indoz.tv',
      'phone': '+1 555 5555',
    };
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    try {
      final url = Uri.parse('${Constants.apiBase}/api/articles');
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body) as List<dynamic>;
        return data.map((e) => e as Map<String, dynamic>).toList();
      }
    } catch (_) {}
    return [];
  }

  Future<List<Ad>> getAds() async {
    try {
      final url = Uri.parse('${Constants.apiBase}/ads');
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body)['ads'] as List<dynamic>;
        return data.map((e) => Ad.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (_) {}
    return [];
  }
}
