import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:url_launcher/url_launcher.dart';

class OutletDetailPage extends StatelessWidget {
  final Map<String, dynamic> outletData;

  const OutletDetailPage({Key? key, required this.outletData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = outletData['name'] as String;
    final code = outletData['code'] as String;
    final address = outletData['address'] as String;
    final logos = outletData['logos'] as List<String>;

    final operatingHours = [
      {'day': 'Minggu', 'hours': '07:00 WIB - 22:00 WIB'},
      {'day': 'Senin', 'hours': '07:00 WIB - 22:00 WIB'},
      {'day': 'Selasa', 'hours': '07:00 WIB - 22:00 WIB'},
      {'day': 'Rabu', 'hours': '07:00 WIB - 22:00 WIB'},
      {'day': 'Kamis', 'hours': '07:00 WIB - 22:00 WIB'},
      {'day': 'Jum\'at', 'hours': '07:00 WIB - 22:00 WIB'},
      {'day': 'Sabtu', 'hours': '07:00 WIB - 22:00 WIB'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppbarPrimary(title: 'Outlet Detail'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16), 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior:
                  Clip.antiAlias, 
              child: Image.asset(
                'assets/image/googlemaps_barata.png',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    '$code - $address',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildServiceOption(
                        'assets/image/image_take_away.png',
                        'Take Away',
                      ),
                      const SizedBox(width: 16),
                      _buildServiceOption(
                        'assets/image/image_delivery.png',
                        'Delivery',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  DottedLine(dashColor: BaseColors.border),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        logos
                            .map(
                              (logo) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Image.asset(logo, height: 28),
                              ),
                            )
                            .toList(),
                  ),

                  const SizedBox(height: 16),

                  DottedLine(dashColor: BaseColors.border),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () async {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Lihat di Peta',
                            style: TextStyle(color: BaseColors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.assistant_direction, color: Colors.white),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Divider(color: BaseColors.border, thickness: 5),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Jam Operasional',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Pickup / Delivery',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  for (var item in operatingHours)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['day']!,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            item['hours']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  item['day'] == 'Selasa'
                                      ? Colors.black
                                      : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceOption(String imageAsset, String label) {
    return Row(
      children: [
        Container(
          child: CircleAvatar(
            backgroundColor: BaseColors.primary,
            child: Image.asset(imageAsset, width: 25, height: 25),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }
}
