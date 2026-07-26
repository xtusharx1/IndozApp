import 'package:flutter/material.dart';
import '../theme.dart';
import './rashpal_profile_screen.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Our Team',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeroSection()),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(
                        'Meet Our Team',
                        'The talented people behind Indoz TV',
                      ),
                      const SizedBox(height: 32),
                      _buildLeadershipSection(context),
                      const SizedBox(height: 40),
                      _buildJournalistsSection(),
                      const SizedBox(height: 40),
                      _buildProductionSection(),
                      const SizedBox(height: 40),
                      _buildMediaPersonalitiesSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.groups_rounded,
              size: 55,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Meet Our Team',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'Dedicated Professionals Behind Indoz TV',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadershipSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leadership',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        _buildTeamMemberRow(
          name: 'Rashpal Heyer',
          role: 'Director',
          description: 'Experienced media professional leading our strategic vision.',
          color: const Color(0xFF1e3a8a),
          email: 'rashpal@indoz.tv',
          phone: '+61 411 036 597',
          imageUrl: 'https://indoz.tv/wp-content/uploads/2026/06/5.png',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RashpalProfileScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildTeamMemberRow(
          name: 'Satpal Kooner',
          role: 'Director',
          description: 'Senior director with a focus on innovative content.',
          color: const Color(0xFFdc2626),
          email: 'satpalkooner@indoz.tv',
          phone: '+61 411 036 598',
          imageUrl: 'https://indoz.tv/wp-content/uploads/2026/06/6.png',
        ),
      ],
    );
  }

  Widget _buildJournalistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Principal Journalists',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        _buildTeamMemberRow(
          name: 'Daljit Singh',
          role: 'Principal Journalist',
          description: 'Veteran journalist with in-depth reporting expertise.',
          color: const Color(0xFF1e40af),
          email: 'daljitsingh@indoz.tv',
          phone: '+61 434 289 317',
          imageUrl: 'https://indoz.tv/wp-content/uploads/2026/06/7.png',
        ),
        const SizedBox(height: 16),
        _buildTeamMemberRow(
          name: 'Harjit Lasara',
          role: 'Principal Journalist',
          description: 'Experienced journalist and investigative reporter.',
          color: const Color(0xFF0369a1),
          email: 'harjit@indoz.tv',
          phone: '+61 XXX XXX XXX',
          imageUrl: 'https://indoz.tv/wp-content/uploads/2026/06/8.png',
        ),
      ],
    );
  }

  Widget _buildProductionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Production & Technical Team',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        _buildTeamMemberRow(
          name: 'Lovey Khattri',
          role: 'Production Manager',
          description: 'Skilled manager overseeing production operations.',
          color: const Color(0xFF9333ea),
          email: 'lovelykhattri@indoz.tv',
          phone: '+61 406 315 400',
          imageUrl: 'https://indoz.tv/wp-content/uploads/2026/06/2.png',
        ),
        const SizedBox(height: 16),
        _buildTeamMemberRow(
          name: 'Kulsharan Heyer',
          role: 'IT Administrator',
          description: 'Technical expert managing our digital infrastructure.',
          color: const Color(0xFF0891b2),
          email: 'kulsharanheyer@indoz.tv',
          phone: '+61 451 955 382',
          imageUrl: null, // Add image URL here
        ),
      ],
    );
  }

  Widget _buildMediaPersonalitiesSection() {
    final personalities = [
      {
        'name': 'Gurdev Sidhu',
        'role': 'Media Personality',
        'description': 'Popular TV and radio host.',
        'color': const Color(0xFF16a34a),
        'imageUrl': 'https://indoz.tv/wp-content/uploads/2026/05/6.png',
      },
      {
        'name': 'Reena Augustine',
        'role': 'Media Personality',
        'description': 'Community advocate and presenter.',
        'color': const Color(0xFFdb2777),
        'imageUrl': 'https://indoz.tv/wp-content/uploads/2026/06/3.png',
      },
      {
        'name': 'Sharmin Thomas',
        'role': 'Media Personality',
        'description': 'Dynamic media host.',
        'color': const Color(0xFFea580c),
        'imageUrl': 'https://indoz.tv/wp-content/uploads/2026/06/4.png',
      },
      {
        'name': 'Varun Basi',
        'role': 'Indoz Tv Australia',
        'description': 'Technical Head and Professional Video Editor',
        'color': const Color(0xFF7c3aed),
        'imageUrl': 'https://indoz.tv/wp-content/uploads/2026/06/Untitled-design.png',
      },
      {
        'name': 'Naser Ali',
        'role': 'Overseas Correspondent',
        'description': 'Global correspondent and journalist.',
        'color': const Color(0xFF0284c7),
        'imageUrl': null,
      },
      {
        'name': 'Gurminder Sidhu',
        'role': 'Production Engineer',
        'description': 'Broadcast technical specialist.',
        'color': const Color(0xFF65a30d),
        'imageUrl': null,
      },
      {
        'name': 'Kulsharan Heyer',
        'role': 'Production Engineer',
        'description': 'Expert in studio operations.',
        'color': const Color(0xFFdc2626),
        'imageUrl': null,
      },
      {
        'name': 'Gurkamal Heyer',
        'role': 'Production Engineer',
        'description': 'Technical support specialist.',
        'color': const Color(0xFF0891b2),
        'imageUrl': null,
      },
      {
        'name': 'Vibha Das-Singh',
        'role': 'Indoz TV Australia',
        'description': 'Host Multiple Cultural Events',
        'color': const Color(0xFFe11d48),
        'imageUrl': 'https://indoz.tv/wp-content/uploads/2026/06/vivas.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Media Personalities & Correspondents',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: personalities.map((person) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildTeamMemberRow(
                name: person['name'] as String,
                role: person['role'] as String,
                description: person['description'] as String,
                color: person['color'] as Color,
                imageUrl: person['imageUrl'] as String?,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMediaPersonalityCard({
    required String name,
    required String role,
    required String description,
    required Color color,
    String? imageUrl,
  }) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image/Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildAvatarFallback(name, color);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        );
                      },
                    )
                  : _buildAvatarFallback(name, color),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.2,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              role,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.65),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberRow({
    required String name,
    required String role,
    required String description,
    required Color color,
    String? email,
    String? phone,
    String? imageUrl,
    VoidCallback? onTap,
  }) {
    final rowContent = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Profile Image/Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildAvatarFallback(name, color);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        );
                      },
                    )
                  : _buildAvatarFallback(name, color),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    role,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
                if (email != null || phone != null) ...[
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (email != null)
                        Row(
                          children: [
                            Icon(Icons.email_rounded, size: 13, color: color),
                            const SizedBox(width: 6),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  email,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (email != null && phone != null)
                        const SizedBox(height: 6),
                      if (phone != null)
                        Row(
                          children: [
                            Icon(Icons.phone_rounded, size: 13, color: color),
                            const SizedBox(width: 6),
                            Text(
                              phone,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: rowContent,
      );
    }
    return rowContent;
  }

  Widget _buildAvatarFallback(String name, Color color) {
    final initials = name
        .split(' ')
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word[0].toUpperCase())
        .join();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Our Team',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeroSection()),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(
                        'Meet Our Team',
                        'The talented people behind Indoz TV',
                      ),
                      const SizedBox(height: 32),
                      _buildLeadershipSection(),
                      const SizedBox(height: 40),
                      _buildTeamMembersSection(),
                      const SizedBox(height: 40),
                      _buildJoinTeamSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.groups_rounded,
              size: 55,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Passionate Storytellers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'Bringing Stories to Life',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadershipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leadership',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildLeaderCard(
                name: 'Rashpal Heyer',
                role: 'Director',
                description: 'Experienced media professional leading our strategic vision.',
                color: const Color(0xFF1e3a8a),
                email: 'rashpal@indoz.tv',
                phone: '+61 411 036 597',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildLeaderCard(
                name: 'Satpal Kooner',
                role: 'Director',
                description: 'Senior director with a focus on innovative content.',
                color: const Color(0xFFdc2626),
                email: 'satpalkooner@indoz.tv',
                phone: '+61 411 036 598',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Principal Journalists',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildTeamMemberCard(
                name: 'Daljit Singh',
                role: 'Principal Journalist',
                description: 'Veteran journalist with in-depth reporting expertise.',
                icon: Icons.newspaper_rounded,
                color: const Color(0xFF1e40af),
                email: 'daljitsingh@indoz.tv',
                phone: '+61 434 289 317',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTeamMemberCard(
                name: 'Harjit Lasara',
                role: 'Principal Journalist',
                description: 'Experienced journalist and investigative reporter.',
                icon: Icons.mic_rounded,
                color: const Color(0xFF0369a1),
                email: 'harjit@indoz.tv',
                phone: '+61 XXX XXX XXX',
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          'Production & Technical Team',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        _buildTeamMemberCard(
          name: 'Lovey Khattri',
          role: 'Production Manager',
          description: 'Skilled manager overseeing production operations.',
          icon: Icons.movie_creation_rounded,
          color: const Color(0xFF9333ea),
          email: 'lovelykhattri@indoz.tv',
          phone: '+61 406 315 400',
        ),
        const SizedBox(height: 16),
        _buildTeamMemberCard(
          name: 'Kulsharan Heyer',
          role: 'IT Administrator',
          description: 'Technical expert managing our digital infrastructure.',
          icon: Icons.computer_rounded,
          color: const Color(0xFF0891b2),
          email: 'kulsharanheyer@indoz.tv',
          phone: '+61 451 955 382',
        ),
        const SizedBox(height: 40),
        Text(
          'Media Personalities',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Gurdev Sidhu',
                role: 'Media Personality',
                description: 'Popular TV and radio host.',
                color: const Color(0xFF16a34a),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Reena Augustine',
                role: 'Media Personality',
                description: 'Community advocate and presenter.',
                color: const Color(0xFFdb2777),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Sharmin Thomas',
                role: 'Media Personality',
                description: 'Dynamic media host.',
                color: const Color(0xFFea580c),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Varun Basi',
                role: 'Overseas Correspondent',
                description: 'International news reporter.',
                color: const Color(0xFF7c3aed),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Naser Ali',
                role: 'Overseas Correspondent',
                description: 'Global correspondent and journalist.',
                color: const Color(0xFF0284c7),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Gurminder Sidhu',
                role: 'Production Engineer',
                description: 'Broadcast technical specialist.',
                color: const Color(0xFF65a30d),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Kulsharan Heyer',
                role: 'Production Engineer',
                description: 'Expert in studio operations.',
                color: const Color(0xFFdc2626),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMediaPersonalityCard(
                name: 'Gurkamal Heyer',
                role: 'Production Engineer',
                description: 'Technical support specialist.',
                color: const Color(0xFF0891b2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Container()), // Empty space for alignment
          ],
        ),
      ],
    );
  }

  Widget _buildJoinTeamSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: IndozTheme.gradientStart.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.work_outline_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Join Our Team',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'We\'re always looking for talented individuals who share our passion for storytelling and community.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.95),
              fontSize: 15,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: const [
                        Icon(Icons.email_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text('Send your resume to: careers@indoz.tv'),
                        ),
                      ],
                    ),
                    backgroundColor: IndozTheme.gradientStart,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 4),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: IndozTheme.gradientStart,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.mail_outline_rounded, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Get In Touch',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderCard({
    required String name,
    required String role,
    required String description,
    required Color color,
    required String email,
    required String phone,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              role,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.email_rounded, size: 14, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        email,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone_rounded, size: 14, color: color),
                    const SizedBox(width: 8),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaPersonalityCard({
    required String name,
    required String role,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.person_rounded,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            role,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: Colors.black.withOpacity(0.65),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard({
    required String name,
    required String role,
    required String description,
    required IconData icon,
    required Color color,
    required String email,
    required String phone,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.65),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email_rounded, size: 14, color: color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            email,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.phone_rounded, size: 14, color: color),
                        const SizedBox(width: 8),
                        Text(
                          phone,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
