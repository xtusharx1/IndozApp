import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/user_service.dart';
import '../services/user_manager.dart';

class ProfileDetailScreen extends StatefulWidget {
  final Map<String, dynamic> initialUser;

  const ProfileDetailScreen({super.key, required this.initialUser});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = false;
  String? _error;
  late String _userId;
  Map<String, dynamic> _originalValues = {};

  @override
  void initState() {
    super.initState();

    // Log the initial user data for debugging
    debugPrint('Received initialUser data: ${widget.initialUser}');

    // Safely extract and assign values with null checks
    _userId = widget.initialUser['_id']?.toString() ?? '';
    _nameController.text = widget.initialUser['name']?.toString() ?? 'User';
    _emailController.text = widget.initialUser['email']?.toString() ?? '';

    // Store original values for comparison
    _originalValues = {
      'name': _nameController.text,
      'email': _emailController.text,
    };

    // Log the initialized values
    debugPrint('Initialized values: userId=$_userId, name=${_nameController.text}, email=${_emailController.text}');
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final bool hasChanges = _nameController.text != _originalValues['name'] ||
        _emailController.text != _originalValues['email'];

    if (!hasChanges) {
      setState(() => _isEditing = false);
      return;
    }

    // Show password verification dialog for any changes
    final password = await _showPasswordDialog(
      title: 'Verify Password',
      message: 'Please enter your password to save changes',
    );
    if (password == null) return;

    setState(() => _isLoading = true);

    try {
      final result = await UserService.updateUser(
        id: _userId,
        name: _nameController.text,
        email: _emailController.text,
        currentPassword: password,
      );

      if (!mounted) return;

      if (result.success) {
        // Update UserManager cache if user data is returned
        if (result.user != null) {
          UserManager.updateCachedUser(result.user!);
        }
        
        setState(() {
          _isEditing = false;
          _originalValues = {
            'name': _nameController.text,
            'email': _emailController.text,
          };
          _error = null;
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        setState(() {
          _error = result.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _handlePasswordChange() async {
    final currentPassword = await _showPasswordDialog(
      title: 'Current Password',
      message: 'Please enter your current password',
    );
    if (currentPassword == null) return;

    final newPassword = await _showPasswordDialog(
      title: 'New Password',
      message: 'Enter your new password',
    );
    if (newPassword == null) return;

    final confirmPassword = await _showPasswordDialog(
      title: 'Confirm Password',
      message: 'Confirm your new password',
    );
    if (confirmPassword == null) return;

    if (newPassword != confirmPassword) {
      if (!mounted) return;
      setState(() => _error = 'New passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await UserService.updateUser(
        id: _userId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (!mounted) return;

      if (result.success) {
        setState(() {
          _isLoading = false;
          _error = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
      } else {
        setState(() {
          _error = result.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<String?> _showPasswordDialog({
    required String title,
    required String message,
  }) async {
    final controller = TextEditingController();
    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    controller.dispose();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom app bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    // Back button
                    Material(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Title
                    Expanded(
                      child: Text(
                        _isEditing ? 'Edit Profile' : 'Profile Details',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Action button
                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      )
                    else
                      IconButton(
                        icon: Icon(
                          _isEditing ? Icons.check : Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_isEditing) {
                            _handleSave();
                          } else {
                            setState(() => _isEditing = true);
                          }
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_error != null) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _error!,
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.red.shade700,
                                  ),
                                  onPressed: () => setState(() => _error = null),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        const Text(
                          'Full Name',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          enabled: _isEditing,
                          decoration: const InputDecoration(
                            hintText: 'Enter your full name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          enabled: _isEditing,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        if (_isEditing) ...[
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _handlePasswordChange,
                              icon: const Icon(Icons.lock_outline),
                              label: const Text('Change Password'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.blue.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Any changes require password verification',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
