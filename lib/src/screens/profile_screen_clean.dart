// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../theme.dart';
// import '../services/api_service.dart';
// import '../services/user_service.dart';
// import '../services/user_manager.dart';
// import './edit_profile_screen.dart';
// import './about_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   Map<String, dynamic>? _user;
//   Map<String, dynamic>? _about;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     setState(() => _isLoading = true);
//     try {
//       _user = await UserManager.getUser();
//       if (_user != null) {
//         debugPrint('User data loaded: ${_user!['name']}');
//       } else {
//         debugPrint('No user data found.');
//       }
//       _about = await ApiService().getAbout();
//     } catch (e) {
//       debugPrint('Error loading profile data: $e');
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = true);
//       }
//     }
//   }
//
//   Future<void> _logout() async {
//     // Show confirmation dialog
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//
//     if (confirmed == true) {
//       try {
//         await UserManager.clearUser();
//         if (mounted) {
//           Navigator.of(context).pushNamedAndRemoveUntil(
//             '/',
//             (route) => false,
//           );
//         }
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error during logout: $e')),
//           );
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
//         ),
//       ),
//       child: SafeArea(
//         child: _isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               )
//             : Column(
//                 children: [
//                   // Header
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Profile',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Refresh profile data
//                             _loadData();
//                           },
//                           icon: const Icon(
//                             Icons.refresh_rounded,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Profile Content
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2),
//                             width: 1,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             // Profile Avatar
//                             Container(
//                               width: 100,
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: const Icon(
//                                 Icons.person_rounded,
//                                 color: Colors.white,
//                                 size: 50,
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//
//                             // User Info
//                             if (_user != null) ...[
//                               Text(
//                                 _user!['name'] ?? 'User',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(
//                                   _user!['email'] ?? 'No email',
//                                   style: TextStyle(
//                                     color: Colors.white.withOpacity(0.9),
//                                     fontSize: 14,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                             const SizedBox(height: 32),
//
//                             // Action buttons
//                             _buildActionButton(
//                               icon: Icons.edit_outlined,
//                               label: 'Edit Profile',
//                               outlined: true,
//                               onPressed: () async {
//                                 // Ensure _user is not null before navigating
//                                 if (_user == null) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('User data is still loading. Please wait.'),
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 // Navigate to EditProfileScreen
//                                 await Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     pageBuilder: (context, animation, secondaryAnimation) =>
//                                         const EditProfileScreen(),
//                                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                                       return SlideTransition(
//                                         position: Tween<Offset>(
//                                           begin: const Offset(1.0, 0.0),
//                                           end: Offset.zero,
//                                         ).animate(animation),
//                                         child: child,
//                                       );
//                                     },
//                                   ),
//                                 );
//
//                                 // Refresh user data after editing
//                                 _loadData();
//                               },
//                             ),
//                             const SizedBox(height: 12),
//
//                             _buildActionButton(
//                               icon: Icons.info_outline,
//                               label: 'About Us',
//                               onPressed: () async {
//                                 final about = _about ?? await ApiService().getAbout();
//                                 if (!mounted) return;
//
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => AboutScreen(
//                                       orgName: about['org_name'] as String? ?? 'About Us',
//                                       description: about['desc'] as String? ?? 'No details available.',
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Logout button at bottom
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         top: BorderSide(
//                           color: Colors.white.withOpacity(0.1),
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _logout,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red.shade600,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 16,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.logout_rounded, size: 20),
//                             SizedBox(width: 8),
//                             Text(
//                               'Logout',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//     bool outlined = false,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: outlined
//               ? Colors.transparent
//               : Colors.white.withOpacity(0.15),
//           foregroundColor: Colors.white,
//           side: outlined
//               ? BorderSide(
//                   color: Colors.white.withOpacity(0.3),
//                   width: 1,
//                 )
//               : null,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 20),
//             const SizedBox(width: 12),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }