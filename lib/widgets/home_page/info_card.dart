import 'package:flutter/material.dart';

//WIDGET VOUCHER DAN REFERRAL

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconAsset; 
  final double marginLeft;
  final double marginRight;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final VoidCallback? onTap;

  const InfoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconAsset, 
    this.marginLeft = 0,
    this.marginRight = 0,
    this.backgroundColor = Colors.white,
    this.iconBackgroundColor = const Color(0xFFE05D56),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E5E5)),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: Colors.black38),
                  ),
                ],
              ),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5), 
                  child: Image.asset(iconAsset, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
