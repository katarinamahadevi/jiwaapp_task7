import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color fallbackColor;
  final String fallbackText;

  const PromoBanner({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.fallbackColor,
    required this.fallbackText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (ctx, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: fallbackColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  fallbackText,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
