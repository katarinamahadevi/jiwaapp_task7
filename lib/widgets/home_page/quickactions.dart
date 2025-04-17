import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/widgets/home_page/action_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: const [
        ActionButton(
          icon: Icons.back_hand_outlined,
          title: "Teman Sejiwa",
          subtitle: "365/400 Exp",
        ),
        ActionButton(
          icon: Icons.monetization_on_outlined,
          title: "Jiwa Point",
          subtitle: "694 Points",
        ),
        ActionButton(
          icon: Icons.calendar_month_outlined,
          title: "Subscription",
          subtitle: "0 Subscription",
        ),
      ],
    );
  }
}
