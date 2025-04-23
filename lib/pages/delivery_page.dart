import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/add_location_page.dart';
import 'package:jiwaapp_task7/pages/update_location_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_delete.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.greyBG,
      appBar: const AppbarPrimary(title: 'Alamat Tersimpan'),
      body: Column(
        children: [
          _buildAddAddressButton(context),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildAddressItem(
                  context: context,
                  title: 'Jalan semolowaru selatan V no.7',
                  name: 'Mahadevi Katarina',
                  phone: '087853591966',
                  address:
                      'Jl. Semolowaru Selatan V No.7, RT.004/RW.03, Semolowaru, Kec. Sukolilo, Surabaya, Jawa Timur 60119, Indonesia',
                  isHighlighted: false,
                ),
                const SizedBox(height: 16),
                _buildAddressItem(
                  context: context,
                  title: 'Perum Perhutani',
                  name: 'Mahadevi Katarina',
                  phone: '628785359166',
                  address:
                      'Jl. Genteng Kali No.8, Genteng, Kec. Genteng, Surabaya, Jawa Timur 60275, Indonesia',
                  isHighlighted: true,
                ),
                const SizedBox(height: 16),
                _buildAddressItem(
                  context: context,
                  title: 'Ordo apps',
                  name: 'Mahadevi Katarina',
                  phone: '628222311668695',
                  address:
                      'Taman Jemursari Selatan I, Jemur Wonosari, Surabaya, Jawa Timur, Indonesia',
                  isHighlighted: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLocationPage()),
          );
        },
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: BaseColors.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: Colors.white, size: 24),
        ),
        title: Text(
          'Tambah Alamat',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Simpan alamat favorit yang kamu mau di sini',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black54),
      ),
    );
  }

  Widget _buildAddressItem({
    required BuildContext context,
    required String title,
    required String name,
    required String phone,
    required String address,
    String? note,
    bool isHighlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 25, 0, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: CircleAvatar(
                          backgroundColor: BaseColors.primary,
                          child: Image.asset(
                            'assets/image/image_address.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 12, 16, 12),
                  child: Text(
                    '$name - $phone',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 16, 0),
                  child: Text(
                    address,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(60, 16, 16, 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.article,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Catatan',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '-',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UpdateLocationPage(
                              addressData: {
                                'title': title,
                                'name': name,
                                'phone': phone.replaceFirst('+62', ''),
                                'address': address,
                              },
                            ),
                      ),
                    );
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    child: CircleAvatar(
                      backgroundColor: BaseColors.greyBG,
                      child: Image.asset(
                        'assets/image/image_update.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Delete Button
                GestureDetector(
                  onTap: () {
                    showModalBottomDelete(context);
                  },

                  // Placeholder for navigation or future implementation
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EditLocationPage(
                  //       addressData: {
                  //         'title': title,
                  //         'name': name,
                  //         'phone': phone,
                  //         'address': address,
                  //       },
                  //     ),
                  //   ),
                  // );
                  child: Container(
                    width: 25,
                    height: 25,
                    child: CircleAvatar(
                      backgroundColor: BaseColors.greyBG,
                      child: Image.asset(
                        'assets/image/image_delete.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
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
