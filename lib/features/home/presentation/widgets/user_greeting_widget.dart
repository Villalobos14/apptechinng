// lib/features/home/presentation/widgets/user_greeting_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../shared/styles/app_text_styles.dart';

class UserGreetingWidget extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const UserGreetingWidget({
    super.key,
    required this.userName,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🚀 Updated to use avatar2.png from assets
        ClipOval(
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/avatar2.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              // 🛡️ Fallback in case image doesn't load
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 48,
                  height: 48,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.person, size: 24),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $userName',
                style: AppTextStyles.homeUserName,
              ),
              Text(
                'Keep practicing every day',
                style: AppTextStyles.homeSubtitle,
              ),
            ],
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onNotificationTap,
          // 🔔 Updated to use bell2.png from assets
          child: Image.asset(
            'assets/images/bell2.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            // 🛡️ Fallback in case image doesn't load
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.notifications_outlined, size: 24);
            },
          ),
        ),
      ],
    );
  }
}