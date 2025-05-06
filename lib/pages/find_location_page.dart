import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:jiwaapp_task7/pages/create_address_page.dart';
import 'package:jiwaapp_task7/pages/search_location_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class FindLocationPage extends StatefulWidget {
  const FindLocationPage({super.key});

  @override
  State<FindLocationPage> createState() => _FindLocationPageState();
}

class _FindLocationPageState extends State<FindLocationPage> {
  final MapController _mapController = MapController();

  final LatLng _centerLocation = const LatLng(-7.2575, 112.7521);

  LatLng _selectedPosition = const LatLng(-7.2575, 112.7521);

  void _recenterMap() {
    _mapController.move(_centerLocation, 15.0);
    setState(() {
      _selectedPosition = _centerLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Replace blue container with flutter_map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // center: _centerLocation,
              // zoom: 15.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedPosition = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.jiwaapp_task7',
              ),
              // Center marker that doesn't move
              // MarkerLayer(
              //   markers: [
              //     Marker(
              //       width: 40.0,
              //       height: 40.0,
              //       point: _selectedPosition,
              //       child: const Icon(
              //         Icons.location_pin,
              //         color: Colors.red,
              //         size: 40.0,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),

          // My location button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.52,
            right: 5,
            child: ElevatedButton(
              onPressed: _recenterMap,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                elevation: 2,
              ),
              child: const Icon(
                Icons.my_location,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Pilih Lokasi',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const SearchLocationPage(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Cari Lokasi',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: BaseColors.border),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ikon lokasi
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: BaseColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/image/image_location.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Alamat
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Taman Jemursari Selatan I No.23, Jemur Wonosari, Kec. Wonocolo, Surabaya, Jawa T...',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Taman Jemursari Selatan I No.23, Jemur Wonosari, Kec. Wonocolo, Surabaya, Jawa Timur 60237, Indonesia',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                    Divider(color: BaseColors.border),
                    // Tombol Konfirmasi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // Pass selected coordinates to CreateAddressPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CreateAddressPage(
                                      addressData: {
                                        // 'latitude': _selectedPosition.latitude,
                                        // 'longitude': _selectedPosition.longitude,
                                        // You can add more data here if needed
                                      },
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BaseColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Konfirmasi',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Centered pin indicator (optional - for better UX)
          Positioned(
            left: 0,
            right: 0,
            top:
                MediaQuery.of(context).size.height *
                0.25, // Adjust for bottom sheet
            child: const Center(
              child: Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
