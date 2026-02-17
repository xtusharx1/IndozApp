import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/api_service.dart';
import '../models/ads_quote_inquiry.dart';
import '../services/user_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  final String orgName;
  final String description;

  const AboutScreen({
    Key? key,
    required this.orgName,
    required this.description,
  }) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'About Us',
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
                      _buildAboutSection(),
                      const SizedBox(height: 40),
                      _buildWhyAdvertiseSection(),
                      const SizedBox(height: 40),
                      _buildBenefitsSection(),
                      const SizedBox(height: 40),
                      _buildPackagesSection(),
                      const SizedBox(height: 40),
                      _buildContactSection(),
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
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
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
              Icons.tv_rounded,
              size: 60,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Indoz TV',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'Telling Stories That Matter',
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

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'About Us',
          'Australian production house, global perspective',
        ),
        const SizedBox(height: 20),
        Text(
          'Indoz TV is a proud Australian production house dedicated to telling the stories of the Punjabi and broader South Asian diaspora. With studios in Brisbane Australia, Patiala India, and Faisalabad Pakistan, we create authentic, high-quality content across sports, fashion, news, health, travel, culture, and entertainment.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.75),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'From our Facebook and YouTube channels that reach thousands across Australia and abroad, to corporate commercials and full-length documentaries, our multilingual team understands the nuances of our community while delivering international production standards.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.75),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                IndozTheme.gradientStart.withOpacity(0.1),
                IndozTheme.gradientEnd.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: IndozTheme.gradientStart.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'We don\'t just produce media—we build connection. Every frame carries the weight of heritage, the energy of now, and the promise of tomorrow.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWhyAdvertiseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Why Advertise With Us',
          'Reach Australia\'s most dynamic demographic',
        ),
        const SizedBox(height: 20),
        Text(
          'Your brand deserves an audience that truly engages. Indoz TV delivers direct access to a highly engaged South Asian diaspora in Australia.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.75),
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        _buildStatCard(
          icon: Icons.groups_rounded,
          title: '784,000',
          subtitle: 'Indian-Australians (2021 Census)',
          description: 'Representing 3.1% of Australia\'s population',
          color: const Color(0xFF667eea),
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.trending_up_rounded,
          title: '10-15M',
          subtitle: 'Unique Views Per Month',
          description: 'Across social media platforms and growing',
          color: const Color(0xFFf5576c),
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.language_rounded,
          title: 'Top 10',
          subtitle: 'Punjabi & Hindi Languages',
          description: '5th and 8th most spoken in Australia',
          color: const Color(0xFF4facfe),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber.withOpacity(0.3), width: 1.5),
          ),
          child: Row(
            children: [
              const Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Indoz TV was purpose-built to serve this vibrant, expanding community with remarkable growth over the past four years.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Benefits of Partnering With Us',
          'Natural integration, measurable results',
        ),
        const SizedBox(height: 20),
        _buildBenefitItem(
          Icons.people_alt_rounded,
          'Targeted Reach',
          'South Asian diaspora across Facebook and YouTube with growing social media presence',
          const Color(0xFF667eea),
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.verified_rounded,
          'Authentic Integration',
          'Sponsorships that feel natural, not forced',
          const Color(0xFFf5576c),
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.view_carousel_rounded,
          'Flexible Formats',
          'Pre-roll, mid-roll, dedicated segments, or full branded series',
          const Color(0xFF4facfe),
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.movie_creation_rounded,
          'Full Production Support',
          'We concept, script, film, and edit your campaign in-house',
          const Color(0xFF9C27B0),
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.analytics_rounded,
          'Measurable Results',
          'Detailed analytics and post-campaign reports',
          const Color(0xFF00BCD4),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade50,
                Colors.teal.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.withOpacity(0.3), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.campaign_rounded, color: Colors.green, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Whether you want to launch a product, build community goodwill, or share your story with our people—we make it beautiful, effective, and true to who we are.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.8),
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPackagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Advertising Packages',
          'Flexible options for every brand',
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Monthly Partnership',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'From ',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const Text(
                    '\$500',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '/month',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Annual brand integration packages available with custom pricing',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => _showAdsQuoteDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: IndozTheme.gradientStart,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.mail_outline_rounded, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Get Custom Quote',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Contact Us',
          'Brisbane Studio & Head Office',
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.purple.shade50],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1.5),
          ),
          child: Column(
            children: [
              _buildContactRow(
                Icons.location_on_rounded,
                '7 Macbarry Place, Rocklea QLD 4106',
                null,
              ),
              const Divider(height: 32),
              _buildContactRow(
                Icons.phone_rounded,
                '0411 036 597',
                'tel:0411036597',
              ),
              const Divider(height: 32),
              _buildContactRow(
                Icons.email_rounded,
                'info@indoz.tv',
                'mailto:info@indoz.tv',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'We\'d love to hear from you.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, String? url) {
    return InkWell(
      onTap: url != null ? () => _launchUrl(url) : null,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: IndozTheme.gradientStart.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: IndozTheme.gradientStart, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showAdsQuoteDialog(BuildContext context) {
    final phoneCtrl = TextEditingController();
    final queryCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool loading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.request_quote_rounded, color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Request Quote',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Let\'s discuss your campaign',
                                    style: TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              icon: const Icon(Icons.close_rounded),
                              color: Colors.black45,
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        TextFormField(
                          controller: phoneCtrl,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '+61 411 036 597',
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: IndozTheme.gradientStart.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.phone_rounded, color: IndozTheme.gradientStart, size: 20),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: IndozTheme.gradientStart, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          validator: (v) => v == null || v.isEmpty || !v.startsWith('+')
                              ? 'Enter phone with country code'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: queryCtrl,
                          minLines: 3,
                          maxLines: 5,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Tell us about your campaign',
                            hintText: 'Budget, goals, target audience...',
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: IndozTheme.gradientEnd.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.edit_note_rounded, color: IndozTheme.gradientEnd, size: 20),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: IndozTheme.gradientStart, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            alignLabelWithHint: true,
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Please describe your needs' : null,
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    if (!formKey.currentState!.validate()) return;
                                    setState(() => loading = true);
                                    final userId = await UserManager.getUserId() ?? '';
                                    final email = await UserManager.getUserEmail();
                                    final inquiry = AdsQuoteInquiry(
                                      userId: userId,
                                      email: email,
                                      phoneNumber: phoneCtrl.text.trim(),
                                      query: queryCtrl.text.trim(),
                                    );
                                    final resp = await ApiService().submitAdsQuoteInquiry(inquiry);
                                    setState(() => loading = false);
                                    if (resp['success'] == true) {
                                      Navigator.of(ctx).pop();
                                      _showAdsQuoteSuccessDialog(context);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(resp['message'] ?? 'Failed')),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: loading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.send_rounded, color: Colors.white, size: 20),
                                          SizedBox(width: 10),
                                          Text(
                                            'Submit Request',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
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
              ),
            );
          },
        );
      },
    );
  }

  void _showAdsQuoteSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quote Request Received!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Your advertising inquiry has been shared. Our team will contact you soon with a custom quote. Thank you for reaching out.',
              style: TextStyle(color: Colors.black54, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: IndozTheme.gradientStart,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Got it!', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}