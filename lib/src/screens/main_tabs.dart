import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'live_screen.dart';
import 'profile_screen.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    LiveScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Exit the app when back button is pressed
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: _pages[_currentIndex],
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          color: Colors.transparent,
          elevation: 8,
          borderRadius: BorderRadius.circular(22),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(3, (index) {
                    final icons = [Icons.home, Icons.live_tv, Icons.person];
                    final labels = ['Home', 'Live', 'Profile'];
                    final isActive = _currentIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _currentIndex = index),
                      child: _NavItem(
                        icon: icons[index],
                        label: labels[index],
                        active: isActive,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.active) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant _NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _ctrl.forward();
    } else if (!widget.active && oldWidget.active) {
      _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Colors.orange, Colors.deepOrangeAccent],
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _ctrl,
          builder: (context, child) {
            final scale = 1.0 + 0.15 * _ctrl.value;
            return Transform.scale(scale: scale, child: child);
          },
          child: widget.active
              ? ShaderMask(
                  shaderCallback: (rect) => gradient.createShader(rect),
                  blendMode: BlendMode.srcIn,
                  child: Icon(widget.icon, size: 26, color: Colors.white),
                )
              : Icon(widget.icon, size: 24, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: widget.active
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )
              : const TextStyle(color: Colors.white70, fontSize: 11),
          child: Text(widget.label),
        ),
      ],
    );
  }
}
