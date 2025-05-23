import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class TabbarPrimary extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;
  final double indicatorWidth;
  final double dividerHeight;
  final Color dividerColor;

  const TabbarPrimary({
    Key? key,
    required this.controller,
    required this.tabs,
    this.indicatorWidth = 20,
    this.dividerHeight = 0.5,
    this.dividerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: controller,
            labelColor: BaseColors.primary,
            unselectedLabelColor: Colors.black87,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: const BorderSide(
                width: 4.0,
                color: BaseColors.primary,
              ),
              insets: EdgeInsets.symmetric(
                horizontal:
                    (MediaQuery.of(context).size.width / tabs.length -
                        indicatorWidth) /
                    2,
              ),
            ),
            indicatorWeight: 0,
            tabs: tabs,
          ),
        ),
        Divider(
          height: dividerHeight,
          thickness: dividerHeight,
          color: dividerColor,
        ),
      ],
    );
  }
}
