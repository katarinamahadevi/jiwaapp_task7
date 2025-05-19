import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/find_location_page.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/create_address_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_secondary.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; 

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({Key? key}) : super(key: key);
  @override
  _SearchLocationPageState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  List<dynamic> _places = [];

  void searchPlace(String input) async {
    if (input.isEmpty) return;

    final apiKey = 'AIzaSyB3frrz_BUtSiFaqTpZQN47bE-oLxGZx-I';
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:id';

    final dio = Dio();

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final json = response.data;
        setState(() {
          _places = json['predictions'];
        });
      }
    } catch (e) {
      print('Error fetching place suggestions: $e');
    }
  }

  Future<Map<String, String>> getPlaceDetails(String placeId) async {
    final apiKey = 'AIzaSyB3frrz_BUtSiFaqTpZQN47bE-oLxGZx-I';
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final dio = Dio();

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final result = response.data['result'];

        if (result != null && result['geometry'] != null) {
          final location = result['geometry']['location'];
          final lat = location['lat'].toString();
          final lng = location['lng'].toString();
          final address = result['formatted_address'] ?? '';

          return {'latitude': lat, 'longitude': lng, 'address': address};
        }
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }

    return {'latitude': '', 'longitude': '', 'address': ''};
  }

  void _onLocationItemTap(dynamic place) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final placeId = place['place_id'];
      final placeDetails = await getPlaceDetails(placeId);

      placeDetails['title'] =
          place['structured_formatting']['main_text'] ?? 'Alamat';
      placeDetails['name'] = ''; 
      placeDetails['phone'] = ''; 

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAddressPage(addressData: placeDetails),
        ),
      );
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Layanan lokasi dinonaktifkan. Silakan aktifkan layanan lokasi.',
          ),
        ),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Izin lokasi ditolak')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Izin lokasi ditolak secara permanen. Silakan ubah di pengaturan perangkat Anda.',
          ),
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        Navigator.pop(context); 
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        final address =
            '${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

        final Map<String, dynamic> addressData = {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'address': address,
          'title': '',
          'name': '', 
          'phone': '', 
        };

        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateAddressPage(addressData: addressData),
          ),
        );
      } else {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat menemukan alamat untuk lokasi ini'),
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.greyBG,
      appBar: AppbarSecondary(
        title: 'Cari lokasi',
        rightIcon: Icons.map_outlined,
        onRightIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FindLocationPage()),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Cari lokasi yang kamu mau...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _isSearching ? Colors.red : Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _isSearching ? Colors.red : Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _isSearching ? Colors.red : BaseColors.primary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: _isSearching ? Colors.red : BaseColors.secondary,
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: _isSearching ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _places.clear();
                                  _isSearching = false;
                                });
                              },
                            )
                            : null,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                  onChanged: searchPlace,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: BaseColors.border),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: BaseColors.primary,
                      child: Icon(Icons.my_location, color: Colors.white),
                    ),
                    title: Text(
                      'Lokasimu saat ini',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: _getCurrentLocation,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey[300]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      leading: CircleAvatar(
                        backgroundColor: BaseColors.primary,
                        child: Image.asset(
                          'assets/image/image_location.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      title: Text(
                        place['structured_formatting']['main_text'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        place['description'],
                        style: TextStyle(fontSize: 10),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => _onLocationItemTap(place),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isSearching = _focusNode.hasFocus && _searchController.text.isNotEmpty;
      });
    });
    _searchController.addListener(() {
      setState(() {
        _isSearching = _focusNode.hasFocus && _searchController.text.isNotEmpty;
      });
    });
  }
}
