import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/appbar_secondary.dart';
import 'package:jiwaapp_task7/widgets/tabbar_primary.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void showTopNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Berhasil membaca semua notifikasi',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

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
        title: 'Notifikasi',
        rightIcon: Icons.checklist,
        iconColor: Color(0xFFFD514F),
        onRightIconPressed: () {
          showTopNotification(context);
        },
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFFAFAFA), width: 6),
              ),
            ),
            child: TabbarPrimary(
              controller: _tabController,
              tabs: const [Tab(text: 'Info (20)'), Tab(text: 'Promo')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: const [
                    NotificationItem(
                      title: 'Transaction',
                      dateTime: '26 Feb 2025 | 13:18',
                      orderId: 'ORDER ID: J+202512617405493000001',
                      heading: 'Mendapat XP dari Transaksi',
                      description: 'Anda mendapatkan 16 XP dari transaksi anda',
                    ),
                    NotificationItem(
                      title: 'Transaction',
                      dateTime: '26 Feb 2025 | 13:18',
                      orderId: 'ORDER ID: J+202512617405493000001',
                      heading: 'Mendapat XP dari Transaksi',
                      description: 'Anda mendapatkan 16 XP dari transaksi anda',
                    ),
                    NotificationItem(
                      title: 'Transaction',
                      dateTime: '26 Feb 2025 | 13:18',
                      orderId: 'ORDER ID: J+202512617405493000001',
                      heading: 'Mendapat XP dari Transaksi',
                      description: 'Anda mendapatkan 16 XP dari transaksi anda',
                    ),
                    NotificationItem(
                      title: 'Transaction',
                      dateTime: '26 Feb 2025 | 13:18',
                      orderId: 'ORDER ID: J+202512617405493000001',
                      heading: 'Mendapat XP dari Transaksi',
                      description: 'Anda mendapatkan 16 XP dari transaksi anda',
                    ),
                  ],
                ), // Promo Tab
                const PromoEmptyState(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PromoEmptyState extends StatelessWidget {
  const PromoEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Image.asset(
            'assets/image/image_notifikasi_promo.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada informasi promo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Informasi promo kamu nanti bisa lihat disini ya!',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String dateTime;
  final String orderId;
  final String heading;
  final String description;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.orderId,
    required this.heading,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with transaction title and date in green container
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFEDF7EC), // Light green background
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.red, // Red dot as in the image
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  dateTime,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // White container for the content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID
                Text(
                  orderId,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                // Notification heading
                Text(
                  heading,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                // Notification description
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFFA0A0A0),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example of adding navigation to the Greetingbar widget

Widget _buildNotificationBadge() {
  return Stack(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFFFD514F),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.notifications, color: Colors.white, size: 16),
      ),
      Positioned(
        right: 0,
        top: 0,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Text(
            "46",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
