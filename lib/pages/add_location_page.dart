import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/search_location_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_secondary.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';

class AddLocationPage extends StatelessWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarSecondary(
        title: 'Cari alamat',
        rightIcon: Icons.map_outlined,
        onRightIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchLocationPage()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(hintText: 'Cari lokasi yang kamu mau...'),

            const SizedBox(height: 16),
            Container(
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

            // Expanded(
            //   child: Container(
            //     width: double.infinity,
            //     margin: const EdgeInsets.only(top: 16),
            //     color: Colors.grey[200],
            //     // In a real implementation, you would place your map widget here
            //     child: Center(
            //       child: Text(
            //         'Map will be displayed here',
            //         style: TextStyle(color: Colors.grey[600]),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
