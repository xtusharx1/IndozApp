import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme.dart';

class RashpalProfileScreen extends StatelessWidget {
  const RashpalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Founder Profile'),
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image Hero Card
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: 'https://indoz.tv/wp-content/uploads/2026/05/WhatsApp-Image-2026-05-16-at-11.46.26-PM-2048x1536.jpeg',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFF1e3a8a).withOpacity(0.1),
                        child: const Center(
                          child: Icon(Icons.person_rounded, size: 80, color: Color(0xFF1e3a8a)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Name and Title Card
                Card(
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Rashpal Heyer',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1e3a8a).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Founder, INDOZ TV',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1e3a8a),
                            ),
                          ),
                        ),
                        const Divider(height: 32),
                        const Text(
                          'Contact Info',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Icon(Icons.email_rounded, size: 18, color: Color(0xFF1e3a8a)),
                            SizedBox(width: 8),
                            Text('rashpal@indoz.tv', style: TextStyle(color: Colors.black87)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.phone_rounded, size: 18, color: Color(0xFF1e3a8a)),
                            SizedBox(width: 8),
                            Text('+61 411 036 597', style: TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Biography Card
                Card(
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Biography',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Rashpal Heyer is the founder of INDOZ TV and a cornerstone of Brisbane’s Punjabi-Sikh community. A passionate cultural activist and entrepreneur, Rashpal began his journey in community media on Radio 4EB, where he helped amplify Punjabi voices through radio programs and creative collaborations. Over the decades, he has organised and led numerous landmark events including Punjabi fashion shows, stage plays (such as Chatura Chor), Bhangra performances, film screenings, and poetry gatherings through INDOZ Theatre. A dedicated community builder, he has also been instrumental in supporting the Australian Sikh Games, ANZAC commemorations for Indian heritage, and various seva initiatives. Today, through INDOZ TV and the INDOZ Sikh Community Centre in Inala, he continues to create platforms that preserve heritage, foster unity, and tell the authentic stories of Punjabis living in Australia.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
