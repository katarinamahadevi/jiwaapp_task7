import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/subscription_page/subscription_history_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_secondary.dart';
import 'package:jiwaapp_task7/widgets/tabbar_primary.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarSecondary(
        title: 'Subscription',
        rightIcon: Icons.history,
        onRightIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscriptionHistoryPage(),
            ),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: TabbarPrimary(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Pencarian'),
                Tab(text: 'Subscription Saya'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSearchSubscriptionView(),
                _builMySubscriptionView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSubscriptionView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFE05D56),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/image/image_subscription.png',
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belum Ada Paket Subscription Saat Ini',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Maaf, saat ini belum tersedia paket subscription yang dapat ditawarkan untukmu. Silakan cek secara berkala!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builMySubscriptionView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFE05D56),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/image/image_subscription.png',
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sayangnya, Kamu Belum Memiliki Subscription',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Yuk, beli subscription dari Janji Jiwa! Dengan ini, kamu bisa lebih menghemat pengeluaran',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 80,
                ),
                elevation: 0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubscriptionPage()),
                  );
                },
                child: const Text(
                  'Cari Subscription',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
