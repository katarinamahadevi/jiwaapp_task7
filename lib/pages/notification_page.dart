import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_secondary.dart';
import 'package:jiwaapp_task7/widgets/notification_page/notification_item.dart';
import 'package:jiwaapp_task7/widgets/notification_page/promo_empty_state.dart';
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
        iconColor: BaseColors.primary,
        rightIcon: Icons.checklist,
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
              children: [_buildInfoTabView(), const PromoEmptyState()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTabView() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: const [
        NotificationItem(
          title: 'Transaction',
          dateTime: '26 Feb 2025 | 13:18',
          orderId: 'ORDER ID: J+202512617405493000001',
          heading: 'Mendapat XP dari Transaksi',
          description: 'Anda mendapatkan 16 XP dari transaksi anda',
        ),
        SizedBox(height: 12),
        NotificationItem(
          title: 'Transaction',
          dateTime: '26 Feb 2025 | 13:18',
          orderId: 'ORDER ID: J+202512617405493000001',
          heading: 'Mendapat XP dari Transaksi',
          description: 'Anda mendapatkan 16 XP dari transaksi anda',
        ),
        SizedBox(height: 12),
        NotificationItem(
          title: 'Transaction',
          dateTime: '26 Feb 2025 | 13:18',
          orderId: 'ORDER ID: J+202512617405493000001',
          heading: 'Mendapat XP dari Transaksi',
          description: 'Anda mendapatkan 16 XP dari transaksi anda',
        ),
        SizedBox(height: 12),
        NotificationItem(
          title: 'Transaction',
          dateTime: '26 Feb 2025 | 13:18',
          orderId: 'ORDER ID: J+202512617405493000001',
          heading: 'Mendapat XP dari Transaksi',
          description: 'Anda mendapatkan 16 XP dari transaksi anda',
        ),
      ],
    );
  }
}
