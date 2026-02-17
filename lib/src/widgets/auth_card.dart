import 'package:flutter/material.dart';
import '../theme.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const AuthCard({super.key, required this.child, this.maxWidth = 420});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
        ),
        child: child,
      ),
    );
  }
}
