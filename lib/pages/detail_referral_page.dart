import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class DetailReferralPage extends StatelessWidget {
  const DetailReferralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0), // biar tidak terlalu mepet
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: BaseColors.primary,
                  size: 16, // sesuai gambar
                ),
              ),
            ),
          ),
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image/image_referral_detail.jpg',
            fit: BoxFit.fitHeight,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.6,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: BaseColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Teman yang diundang',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          '2 Teman',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: screenHeight * 0.48,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFriendItem("Maharani Tasha Nabila", true),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("bhagas", true),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Dewi Kusuma", false),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Agus Santoso", true),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Lisa Permata", false),
                            const SizedBox(height: 16),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Lisa Permata", false),
                            const SizedBox(height: 16),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Lisa Permata", false),
                            const SizedBox(height: 16),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Lisa Permata", false),
                            const SizedBox(height: 16),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Lisa Permata", false),
                            const SizedBox(height: 16),
                            const Divider(color: BaseColors.border),
                            _buildFriendItem("Lisa Permata", false),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(String name, bool isActive) {
    final backgroundColor =
        isActive
            ? BaseColors.greenContainer
            : const Color(0xFFE0E0E0); // abu-abu muda
    final textColor =
        isActive
            ? BaseColors.greenText
            : const Color(0xFF757575); // abu-abu tua

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isActive ? "Active" : "Inactive",
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
