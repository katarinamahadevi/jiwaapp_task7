import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:url_launcher/url_launcher.dart';

class OutletDetailPage extends StatefulWidget {
  final Map<String, dynamic> outletData;

  const OutletDetailPage({Key? key, required this.outletData})
    : super(key: key);

  @override
  State<OutletDetailPage> createState() => _OutletDetailPageState();
}

class _OutletDetailPageState extends State<OutletDetailPage> {
  final LatLng _outletLocation = const LatLng(
    -7.2575,
    112.7521,
  ); 

  void _openMaps(BuildContext context) async {
    // Create map URL with the coordinates
    final Uri mapsUri = Uri.parse(
      'https://www.openstreetmap.org/?mlat=${_outletLocation.latitude}&mlon=${_outletLocation.longitude}&zoom=16',
    );

    try {
      bool launched = await launchUrl(
        mapsUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tidak dapat membuka peta')),
          );
        }
      }
    } catch (e) {
      print('Error membuka peta: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.outletData['name'] as String;
    final code = widget.outletData['code'] as String;
    final address = widget.outletData['address'] as String;
    final logos = widget.outletData['logos'] as List<String>;

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
            // Replace the image asset with flutter_map
            Container(
              margin: const EdgeInsets.all(16),
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _outletLocation.latitude,
                    _outletLocation.longitude,
                  ),
                  zoom: 15.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('outlet_marker'),
                    position: LatLng(
                      _outletLocation.latitude,
                      _outletLocation.longitude,
                    ),
                    infoWindow: InfoWindow(title: widget.outletData['name']),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed,
                    ),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  // controller bisa disimpan untuk navigasi kamera
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
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
                    style: const TextStyle(
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
                      onPressed: () {
                        _openMaps(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                  const Align(
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

                  const Align(
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
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
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

                  const SizedBox(height: 24),
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
        CircleAvatar(
          backgroundColor: BaseColors.primary,
          child: Image.asset(imageAsset, width: 25, height: 25),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }
}
