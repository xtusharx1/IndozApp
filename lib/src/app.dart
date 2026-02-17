import 'package:flutter/material.dart';
import 'theme.dart';
import 'utils/routes.dart';

class IndozTVApp extends StatefulWidget {
  final String initialRoute;
  const IndozTVApp({super.key, this.initialRoute = Routes.landing});

  @override
  State<IndozTVApp> createState() => _IndozTVAppState();
}

class _IndozTVAppState extends State<IndozTVApp> {
  late final String _initialRoute = widget.initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indoz TV',
      debugShowCheckedModeBanner: false,
      theme: IndozTheme.lightTheme,
      initialRoute: _initialRoute,
      routes: Routes.appRoutes,
    );
  }
}
