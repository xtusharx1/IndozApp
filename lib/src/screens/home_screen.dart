import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/article_card.dart';
import '../services/api_service.dart';
import '../services/user_manager.dart';
import '../models/article.dart';
import '../models/ad.dart';
import 'package:android_app/src/screens/hire_studio_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _name = 'User';
  List<Article> _articles = [];
  bool _loadingArticles = true;
  int _displayCount = 10; // Changed: Track how many articles to display

  // Trending carousel
  late final PageController _pageController;
  int _currentTrending = 0;
  Timer? _autoScrollTimer;

  // Header animation
  late final AnimationController _headerController;
  late final Animation<double> _headerOpacity;

  List<Ad> _ads = [];
  bool _loadingAds = true;

  late Map<String, String> _socialMediaLinks = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _headerOpacity = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeInOut,
    );

    _headerController.forward();

    _loadUser();
    _loadArticles();
    _loadAds();
    _loadSocialMediaLinks();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    _headerController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    setState(() => _loadingArticles = true);
    try {
      final api = ApiService();
      final data = await api.getArticles();
      final list = data.map((e) => Article.fromJson(e)).toList();
      
      // Sort by createdAt in descending order (latest first)
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      if (mounted) setState(() => _articles = list);

      // Setup auto-scroll when we have at least 2 trending items
      final trending = _articles.where((a) => a.isTrending).toList();
      _autoScrollTimer?.cancel();
      if (trending.length > 1) {
        _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
          if (_pageController.hasClients) {
            final next = (_currentTrending + 1) % _ads.length;
            _pageController.animateToPage(
              next,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    } catch (_) {
      // ignore errors for now
    } finally {
      if (mounted) setState(() => _loadingArticles = false);
    }
  }

  Future<void> _loadUser() async {
    try {
      final username = await UserManager.getUsername();
      if (mounted) {
        setState(() => _name = username);
      }
    } catch (e) {
      print('Error loading user: $e');
      if (mounted) {
        setState(() => _name = 'User');
      }
    }
  }

  Future<void> _loadAds() async {
    setState(() => _loadingAds = true);
    try {
      final api = ApiService();
      final data = await api.getAds();
      final list = data
          .where((ad) => ad.isActive)
          .toList()
        ..sort((a, b) => a.type == 'internal' ? -1 : 1);
      if (mounted) setState(() => _ads = list);
    } catch (_) {
      // Handle errors silently for now
    } finally {
      if (mounted) setState(() => _loadingAds = false);
    }
  }

  Future<void> _loadSocialMediaLinks() async {
    final links = await UserManager.getSocialMediaLinks();
    if (mounted) {
      setState(() => _socialMediaLinks = links);
    }
  }

  // Changed: Display articles based on _displayCount
  List<Article> get _displayedArticles {
    if (_displayCount >= _articles.length) {
      return _articles;
    }
    return _articles.take(_displayCount).toList();
  }

  // Changed: Check if there are more articles to show
  bool get _hasMoreArticles {
    return _articles.length > _displayCount;
  }

  // Changed: Calculate remaining articles
  int get _remainingArticles {
    return _articles.length - _displayCount;
  }

  // Changed: Load 5 more articles
  void _loadMoreArticles() {
    setState(() {
      _displayCount += 5;
    });
  }

  // Changed: Reset to show only first 10
  void _showLess() {
    setState(() {
      _displayCount = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    final trending = _articles.where((a) => a.isTrending).toList();

    String _formatDate(DateTime dt) {
      final d = dt.toLocal();
      const monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final month = monthNames[d.month - 1];
      return '$month ${d.day}, ${d.year}';
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
        ),
      ),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadArticles();
            setState(() => _displayCount = 10); // Changed: Reset display count
          },
          color: Colors.white,
          backgroundColor: Colors.transparent,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: FadeTransition(
                    opacity: _headerOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome, $_name',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 450),
                                  child: Text(
                                    _loadingArticles
                                        ? 'Fetching top stories...'
                                        : 'Here are the latest headlines',
                                    key: ValueKey<bool>(_loadingArticles),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Ads carousel
              SliverToBoxAdapter(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth;
                    final cardWidth = maxWidth * 0.82;
                    final cardHeight = cardWidth / (16 / 9);

                    return SizedBox(
                      height: cardHeight + 40,
                      child: _loadingAds
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : _ads.isEmpty
                              ? Center(
                                  child: Text(
                                    'No active ads',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: PageView.builder(
                                        controller: _pageController,
                                        itemCount: _ads.length,
                                        onPageChanged: (p) =>
                                            setState(() => _currentTrending = p),
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final ad = _ads[index];
                                          return AnimatedBuilder(
                                            animation: _pageController,
                                            builder: (context, child) {
                                              double value = 1.0;
                                              if (_pageController.hasClients &&
                                                  _pageController
                                                      .position
                                                      .haveDimensions &&
                                                  _pageController.page != null) {
                                                value =
                                                    (_pageController.page! - index)
                                                        .abs();
                                                value = (1 - (value * 0.2)).clamp(
                                                  0.8,
                                                  1.0,
                                                );
                                              }
                                              return Transform.scale(
                                                scale: value,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                    right: 12.0,
                                                  ),
                                                  child: Center(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        final url = ad.redirectUrl.trim();

                                                        // If no URL → stay static
                                                        if (url.isEmpty) return;

                                                        if (url.contains('hire_studio')) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => HireStudioScreen(
                                                                adImageUrl: ad.adImage,
                                                              ),
                                                            ),
                                                          );
                                                          return;
                                                        }

                                                        try {
                                                          final uri = Uri.parse(url);
                                                          await launchUrl(
                                                            uri,
                                                            mode: LaunchMode.platformDefault,
                                                          );
                                                        } catch (e) {
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Unable to open: $url'),
                                                                backgroundColor: Colors.red,
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        width: cardWidth,
                                                        height: cardHeight,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                            14,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black
                                                                  .withOpacity(0.35),
                                                              blurRadius: 18,
                                                              offset: const Offset(
                                                                0,
                                                                8,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                            14,
                                                          ),
                                                          child: Image.network(
                                                            ad.adImage,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Dots indicator
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(_ads.length, (i) {
                                        final active = i == _currentTrending;
                                        return AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          width: active ? 18 : 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: active
                                                ? IndozTheme.accentOrange
                                                : Colors.white24,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                    );
                  },
                ),
              ),

              // Social Media Section
              if (_socialMediaLinks.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialMediaButton(
                          icon: Icons.facebook,
                          url: _socialMediaLinks['facebook'] ?? 'https://facebook.com/indoztv',
                          color: const Color(0xFF1877F2),
                        ),
                        const SizedBox(width: 20),
                        _buildSocialMediaButton(
                          icon: FontAwesomeIcons.youtube,
                          url: _socialMediaLinks['youtube'] ?? 'https://www.youtube.com/channel/UCb2SKOElTU5sAiedbDNFMMw',
                          color: const Color(0xFFFF0000),
                        ),
                        const SizedBox(width: 20),
                        _buildSocialMediaButton(
                          icon: FontAwesomeIcons.instagram,
                          url: _socialMediaLinks['instagram'] ?? 'https://www.instagram.com/official_indoz.tv/',
                          color: const Color(0xFFE4405F),
                        ),
                      ],
                    ),
                  ),
                ),

              // Latest header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest News',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_articles.isNotEmpty)
                        Text(
                          'Showing ${_displayedArticles.length} of ${_articles.length}',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Article list
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    final art = _displayedArticles[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        tileColor: Colors.white.withOpacity(0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          art.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          _formatDate(art.createdAt),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/article',
                          arguments: art,
                        ),
                      ),
                    );
                  }, childCount: _displayedArticles.length),
                ),
              ),

              // View More Button (Changed: Shows next 5 or remaining count)
              if (_hasMoreArticles)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loadMoreArticles,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'View More Articles',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(${_remainingArticles > 5 ? "5" : _remainingArticles} more)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Show Less Button (when more than 10 articles are shown)
              if (_displayCount > 10)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: _showLess,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.keyboard_arrow_up_rounded, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Show Less',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaButton({
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return _SocialMediaButton(
      icon: icon,
      url: url,
      color: color,
    );
  }
}

class _SocialMediaButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color color;

  const _SocialMediaButton({
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  State<_SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<_SocialMediaButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glowAnimation = Tween<double>(begin: 8.0, end: 16.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      onTap: () async {
        try {
          final uri = Uri.parse(widget.url);
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Unable to open social media link'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.6),
                    blurRadius: _glowAnimation.value,
                    spreadRadius: _glowAnimation.value / 4,
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}