import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/notification_controller.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/notification_service.dart';
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
  late NotificationController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final apiClient = ApiClient();
    final notificationService = NotificationService(apiClient);
    _controller = Get.put(NotificationController(notificationService));
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
          // contoh fungsi, bisa kamu ganti
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berhasil membaca semua notifikasi')),
          );
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
              tabs: const [Tab(text: 'Info'), Tab(text: 'Promo')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Obx(() {
                  if (_controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (_controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(_controller.errorMessage.value));
                  }
                  if (_controller.notifications.isEmpty) {
                    return const Center(child: Text('Belum ada notifikasi'));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _controller.notifications.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = _controller.notifications[index];

                      // sesuaikan field dengan parameter NotificationItem
                      final dateTime = '${item.date} | ${item.time}';
                      final orderId = 'ORDER ID: ${item.orderCode}';
                      final title = item.type.capitalizeFirst ?? item.type;
                      final heading = item.title;
                      final description = item.message;

                      return NotificationItem(
                        title: title,
                        dateTime: dateTime,
                        orderId: orderId,
                        heading: heading,
                        description: description,
                      );
                    },
                  );
                }),
                const PromoEmptyState(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
