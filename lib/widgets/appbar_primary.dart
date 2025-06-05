import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import '../pages/home_page.dart';

//APPBAR HANYA ICON BACK DAN TITLE PAGE

class AppbarPrimary extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Color backgroundColor;
  final Color iconColor;
  final Color titleColor;
  final FontWeight titleFontWeight;
  final double elevation;
  final List<Widget>? actions;

  const AppbarPrimary({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.titleColor = Colors.black,
    this.titleFontWeight = FontWeight.w500,
    this.elevation = 0,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed:
            onBackPressed ??
            () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                print("Tidak ada halaman sebelumnya");
                Get.offAll(() => HomePage());
              }
            },
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontWeight: titleFontWeight),
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: BaseColors.border, height: 2),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
