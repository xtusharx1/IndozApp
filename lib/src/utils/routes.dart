import 'package:flutter/material.dart';
import '../screens/landing_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/main_tabs.dart';
import '../screens/article_detail_screen.dart';

class Routes {
  static const landing = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const main = '/main';
  static const articleDetail = '/article';
  static final Map<String, WidgetBuilder> appRoutes = {
    landing: (_) => const LandingScreen(),
    login: (_) => const LoginScreen(),
    signup: (_) => const SignupScreen(),
    main: (_) => const MainTabs(),
    articleDetail: (_) => const ArticleDetailScreen(),
  };
}
