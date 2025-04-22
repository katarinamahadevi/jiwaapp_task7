import 'package:flutter/material.dart';

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
    this.dividerColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: controller,
            labelColor: const Color(0xFFFD514F),
            unselectedLabelColor: Colors.black87,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(
                width: 4.0,
                color: Color(0xFFFD514F),
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
