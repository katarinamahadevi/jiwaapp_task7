import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/my_voucher_page.dart';
import 'package:jiwaapp_task7/pages/referral_page.dart';
import 'package:jiwaapp_task7/widgets/home_page/info_card.dart';

class InfoCards extends StatelessWidget {
  const InfoCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            title: "Voucher Kamu",
            subtitle: "19 Voucher",
            iconAsset: 'assets/image/image_voucher.png',
            marginRight: 8,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyVoucherPage()),
              );
            },
          ),
        ),
        Expanded(
          child: InfoCard(
            title: "Referral",
            subtitle: "Undang Temanmu",
            iconAsset: 'assets/image/image_referral.png',
            marginLeft: 8,
           onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReferralPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}
