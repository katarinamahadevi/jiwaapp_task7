import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;  // Added onTap callback

  const ActionButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle, 
    this.backgroundColor = const Color(0xFFFD514F),
    this.iconColor = Colors.white,
    this.onTap,  // Made optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // Wrap in GestureDetector
      onTap: onTap,  // Use onTap callback
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}