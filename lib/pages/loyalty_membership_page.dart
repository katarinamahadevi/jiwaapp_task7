import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/jiwa_point_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class LoyaltyMembershipPage extends StatefulWidget {
  const LoyaltyMembershipPage({super.key});

  @override
  State<LoyaltyMembershipPage> createState() => _LoyaltyMembershipPageState();
}

class _LoyaltyMembershipPageState extends State<LoyaltyMembershipPage> {
  late int currentLevelIndex;
  late PageController _pageController;

  final membershipLevels = [
    {
      'name': 'Jiwa',
      'icon': 'assets/image/image_loyalty_membership.png',
      'iconLocked': 'assets/image/image_loyalty_membership.png',
      'current': true,
      'xp': 100,
      'maxXp': 100,
      'description': '',
      'showProgress': true,
    },
    {
      'name': 'Teman Sejiwa',
      'icon': 'assets/image/image_teman_sejiwa.png',
      'iconLocked': 'assets/image/image_teman_sejiwa.png',
      'current': true,
      'xp': 362,
      'maxXp': 400,
      'description': '',
      'showProgress': true,
    },
    {
      'name': 'Sahabat Sejiwa',
      'icon': 'assets/image/image_teman_sejiwa.png',
      'iconLocked': 'assets/image/image_saudara_sejiwa.png',
      'current': false,
      'xp': 0,
      'maxXp': 100,
      'description': 'Kurang 38 XP lagi untuk menjadi level ini',
      'showProgress': false,
    },
    {
      'name': 'Belahan Jiwa',
      'icon': 'assets/image/image_teman_sejiwa.png',
      'iconLocked': 'assets/image/image_saudara_sejiwa.png',
      'current': false,
      'xp': 0,
      'maxXp': 0,
      'description': 'Kurang 100 XP lagi untuk menjadi level ini',
      'showProgress': false,
    },
  ];

  @override
  void initState() {
    super.initState();

    currentLevelIndex = membershipLevels.indexWhere(
      (level) => level['current'] == true && level['xp'] != level['maxXp'],
    );
    if (currentLevelIndex == -1) {
      currentLevelIndex = membershipLevels.lastIndexWhere(
        (level) => level['current'] == true,
      );
    }
    if (currentLevelIndex == -1) currentLevelIndex = 0;

    _pageController = PageController(
      viewportFraction: 0.5,
      initialPage: currentLevelIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final purpleContainerHeight = calculatePurpleContainerHeight(
      currentLevelIndex,
    );
    final jiwaPointTopPosition = purpleContainerHeight - 50;
    final rewardsTopPosition = jiwaPointTopPosition + 120;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: BaseColors.secondary,
        title: const Text(
          'Loyalty Membership',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
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
              height: MediaQuery.of(context).size.height * 1.8,
              width: double.infinity,
            ),
            Container(
              height: purpleContainerHeight,
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
                  const SizedBox(height: 80),
                  buildMembershipLevelSlider(),
                ],
              ),
            ),
            Positioned(
              top: jiwaPointTopPosition,
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
              top: rewardsTopPosition,
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

  double calculatePurpleContainerHeight(int index) {
    double baseHeight = 450.0;

    final level = membershipLevels[index];

    if ((level['description'] as String).isNotEmpty) {
      baseHeight += 20.0;
    }

    return baseHeight;
  }

  Widget buildMembershipLevelSlider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 280,
              child: PageView.builder(
                itemCount: membershipLevels.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentLevelIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final level = membershipLevels[index];
                  final bool isCurrent = level['current'] == true;
                  final double progress =
                      (level['maxXp'] as int) > 0
                          ? (level['xp'] as int) / (level['maxXp'] as int)
                          : 0.0;
                  final bool isComplete = progress >= 1.0;

                  bool isCenter = index == currentLevelIndex;

                  return Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: isCenter ? 150 : 120,
                            height: isCenter ? 150 : 120,
                            decoration: BoxDecoration(
                              color:
                                  isCurrent
                                      ? BaseColors.primary
                                      : const Color(0xFF666B71),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      isCurrent
                                          ? (isComplete
                                                  ? level['icon']
                                                  : level['icon'])
                                              as String
                                          : level['iconLocked'] as String,
                                      width: isCenter ? 110 : 80,
                                      height: isCenter ? 110 : 80,
                                    ),
                                  ),
                                  if (!isCurrent)
                                    Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: isCenter ? 40 : 30,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (isCenter) ...[
                            const SizedBox(height: 15),
                            Text(
                              level['name'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if ((level['description'] as String).isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  level['description'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (level['showProgress'] == true)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 15),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth * 0.45,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: BaseColors.primary,
                                          radius: 12,
                                          child: Image.asset(
                                            level['icon'] as String,
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.white38,
                                            color:
                                                isCurrent
                                                    ? BaseColors.primary
                                                    : Colors.grey,
                                            minHeight: 5,
                                            borderRadius:
                                                const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        CircleAvatar(
                                          backgroundColor: BaseColors.primary,
                                          radius: 12,
                                          child: Image.asset(
                                            level['icon'] as String,
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${level['xp']} / ${level['maxXp']} XP',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildReferralBenefitCard({
    required String title,
    required String description,
    required String imageAssetPath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(25),
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
          Image.asset(imageAssetPath, width: 40, height: 45),
        ],
      ),
    );
  }
}
