import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/loyalty_membership_page.dart';
import 'package:jiwaapp_task7/pages/subscription_page.dart';
import 'package:jiwaapp_task7/pages/jiwa_point_page.dart';
import 'package:jiwaapp_task7/widgets/home_page/action_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        ActionButton(
          iconAsset: 'assets/image/image_teman_sejiwa.png',
          title: "Teman Sejiwa",
          subtitle: "365/400 Exp",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoyaltyMembershipPage(),
              ),
            );
          },
        ),
        ActionButton(
          iconAsset: 'assets/image/image_jiwapoint.png',
          title: "Jiwa Point",
          subtitle: "694 Points",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JiwaPointPage()),
            );
          },
        ),
        ActionButton(
          iconAsset: 'assets/image/image_subscription.png',
          title: "Subscription",
          subtitle: "0 Subscription",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SubscriptionPage()),
            );
          },
        ),
      ],
    );
  }
}
