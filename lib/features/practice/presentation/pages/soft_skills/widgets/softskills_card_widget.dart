// lib/features/practice/presentation/pages/soft_skills/widgets/softskills_card_widget.dart
import 'package:flutter/material.dart';

class SoftskillsCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color cardColor;
  final VoidCallback onTap;

  const SoftskillsCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.cardColor,
    required this.onTap,
  });

  Widget _buildIllustration() {
    String assetPath;
    
    if (title == 'Random') {
      assetPath = 'assets/images/random.png';
    } else if (title == 'Learning Journey') {
      assetPath = 'assets/images/learn.png';
    } else if (title == 'Specify Your Own') {
      assetPath = 'assets/images/specify.png';
    } else {
      assetPath = 'assets/images/learn.png'; // Default fallback
    }

    return SizedBox(
      width: 160,
      height: 160,
      child: Image.asset(
        assetPath,
        width: 160,
        height: 160,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to icon if image fails to load
          return Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              _getIconForTitle(),
              size: 80,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForTitle() {
    if (title == 'Random') {
      return Icons.shuffle;
    } else if (title == 'Learning Journey') {
      return Icons.book;
    } else {
      return Icons.settings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration area
            _buildIllustration(),
            
            const SizedBox(height: 32),
            
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.9),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}