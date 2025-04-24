import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/jiwa_point_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class LoyaltyMembershipPage extends StatelessWidget {
  const LoyaltyMembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: BaseColors.secondary,
        title: const Text(
          'Loyalty Membership',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: BaseColors.white,
              height: MediaQuery.of(context).size.height * 1.5,
              width: double.infinity,
            ),
            Container(
              height: 450,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: BaseColors.secondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 120), 
                  buildMembershipLevelSlider(),
                ],
              ),
            ),
            Positioned(
              top: 400,
              left: 20,
              right: 20,
              child: Container(
                height: 88,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: BaseColors.border),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jiwa Point',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'assets/image/image_jiwapoint_white.png',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '694',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JiwaPointPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        textStyle: const TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('History'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 520,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/image_rewards.png',
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Rewards Kamu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildReferralBenefitCard(
                    title: 'Referral Benefit',
                    description: 'Diskon 50% Maks. 20k',
                    imageAssetPath: 'assets/image/image_referral.png',
                  ),
                  buildReferralBenefitCard(
                    title: 'Level Up Diskon',
                    description: 'Diskon 50% Maks. 20k',
                    imageAssetPath: 'assets/image/image_levelup_discount.png',
                  ),
                  buildReferralBenefitCard(
                    title: 'Birthday Voucher',
                    description: 'Diskon 50% Maks. 50k',
                    imageAssetPath: 'assets/image/image_birthday_voucher.png',
                  ),
                  buildReferralBenefitCard(
                    title: '3x Voucher Diskon Bulanan',
                    description:
                        'Diskon 20% Min. pembelian 70k, Maks. Diskon 20k',
                    imageAssetPath: 'assets/image/image_discount_month.png',
                  ),
                  buildReferralBenefitCard(
                    title: '4x Voucher Diskon Bulanan',
                    description:
                        'Diskon 15% Min. pembelian 35k, Maks. Diskon 15k',
                    imageAssetPath: 'assets/image/image_discount_month.png',
                  ),
                  buildReferralBenefitCard(
                    title: '10x Diskon Ongkir',
                    description: 'Diskon voucher ongkir 20% Maks.12k',
                    imageAssetPath: 'assets/image/image_delivery_discount.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMembershipLevelSlider() {
    final membershipLevels = [
      {
        'name': 'Jiwa',
        'icon': 'assets/image/image_loyalty_membership.png',
        'current': true,
      },
      {
        'name': 'Teman Sejiwa',
        'icon': 'assets/image/image_teman_sejiwa.png',
        'current': true,
      },
      {
        'name': 'Saudara Sejiwa',
        'icon': 'assets/image/image_referral.png',
        'current': false,
      },
      {
        'name': 'Belahan Jiwa',
        'icon': 'assets/image/image_birthday_voucher.png',
        'current': false,
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: membershipLevels.length,
            controller: PageController(viewportFraction: 1.0),
            padEnds: false,
            itemBuilder: (context, index) {
              final level = membershipLevels[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color:
                            level['current'] == true
                                ? BaseColors.primary
                                : Colors.grey.withOpacity(0.3),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Center(
                        child: Image.asset(
                          level['icon'] as String,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      level['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: BaseColors.primary,
                child: Image.asset(
                  'assets/image/image_loyalty_membership.png',
                  height: 24,
                  width: 24,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.white38,
                  color: BaseColors.primary,
                  minHeight: 5,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: BaseColors.primary,
                child: Image.asset(
                  'assets/image/image_teman_sejiwa.png',
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ),
        const Text(
          '100 / 100 XP',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildReferralBenefitCard({
    required String title,
    required String description,
    required String imageAssetPath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: BaseColors.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ],
          ),
          Image.asset(imageAssetPath, width: 50, height: 50),
        ],
      ),
    );
  }
}
