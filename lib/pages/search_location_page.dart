import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/create_address_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_secondary.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';

class SearchLocationPage extends StatelessWidget {
  const SearchLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarSecondary(
        title: 'Cari alamat',
        rightIcon: Icons.map_outlined,
        onRightIconPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => CreateAddressPage()),
          // );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(hintText: 'Cari lokasi yang kamu mau...'),

            const SizedBox(height: 16),
            GestureDetector(
              onTap:
                  () => CreateAddressPage(
                    addressData: {
                      'title': 'Rumah',
                      'address': 'Jl. Klampis No. 12, Surabaya',
                      'name': 'Mahadevi Sabila',
                      'phone': '081234567890',
                    },
                  ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: BaseColors.primary,
                    child: Icon(Icons.my_location, color: Colors.white),
                  ),
                  title: Text(
                    'Lokasimu saat ini',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
