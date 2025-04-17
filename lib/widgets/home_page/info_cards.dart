import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/widgets/home_page/info_card.dart';

class InfoCards extends StatelessWidget {
  const InfoCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: InfoCard(
            title: "Voucher Kamu",
            subtitle: "19 Voucher",
            icon: Icons.card_giftcard,
            marginRight: 8,
          ),
        ),
        Expanded(
          child: InfoCard(
            title: "Referral",
            subtitle: "Undang Temanmu",
            icon: Icons.share,
            marginLeft: 8,
          ),
        ),
      ],
    );
  }
}