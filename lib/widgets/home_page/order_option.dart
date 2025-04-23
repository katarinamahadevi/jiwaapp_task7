import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class OrderOptionButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final double marginLeft;
  final double marginRight;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  const OrderOptionButton({
    Key? key,
    required this.imageAsset,
    required this.label,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.backgroundColor = const Color(0xFF4A154B),
    this.iconBackgroundColor = const Color(0xFFE05D56),
    this.textColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95,
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
