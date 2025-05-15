import 'package:flutter/material.dart';

import '../../../../common/icons/google_icon.dart';

class AuthButtons extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onGuestLogin;
  final bool showDivider;

  const AuthButtons({
    super.key,
    required this.onGoogleLogin,
    required this.onGuestLogin,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showDivider) ...[
          // Or divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade400)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade400)),
            ],
          ),
          const SizedBox(height: 16),
        ],

        // Google Sign In button
        OutlinedButton.icon(
          onPressed: onGoogleLogin,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          icon: const Icon(Google.google),
          label: const Text('Continue with Google'),
        ),
        const SizedBox(height: 12),

        // Continue as Guest button
        OutlinedButton.icon(
          onPressed: onGuestLogin,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          icon: const Icon(Icons.person_outline),
          label: const Text('Continue as Guest'),
        ),
      ],
    );
  }
}
