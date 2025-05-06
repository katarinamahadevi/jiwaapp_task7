import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

//MODAL BOTTOM KEWARGANEGARAAN

class ModalBottomCountryRegister extends StatefulWidget {
  final List<String> countries;
  final String? initialValue;
  final Function(String) onCountrySelected;

  const ModalBottomCountryRegister({
    Key? key,
    required this.countries,
    this.initialValue,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  State<ModalBottomCountryRegister> createState() => _ModalbottomCountryState();
}

class _ModalbottomCountryState extends State<ModalBottomCountryRegister> {
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with close button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Kewarganegaraan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(color: BaseColors.border),

          // List of countries
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.countries.length,
              separatorBuilder:
                  (context, index) => const Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: BaseColors.border,
                  ),
              itemBuilder: (context, index) {
                final country = widget.countries[index];
                final isSelected = country == _selectedCountry;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    country,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                  trailing: Radio<String>(
                    value: country,
                    groupValue: _selectedCountry,
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value;
                      });
                    },
                    activeColor: BaseColors.primary,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedCountry = country;
                    });
                  },
                );
              },
            ),
          ),

          // Confirmation button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    _selectedCountry != null
                        ? () {
                          widget.onCountrySelected(_selectedCountry!);
                          Navigator.pop(context);
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  disabledBackgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
