import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:jiwaapp_task7/theme/color.dart';

//UNTUK TAMPILAN COMBO - Modified untuk menampilkan food & drink

class ItemOptionsWidget extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> options;
  final String selectedOption;
  final Function(String) onOptionSelected;

  const ItemOptionsWidget({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Column(
          children:
              options.map((option) {
                bool isSelected = selectedOption == option['id'].toString();

                String priceValue = '';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: InkWell(
                    // FIX: Pass ID, not name
                    onTap: () => onOptionSelected(option['id'].toString()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color:
                                    isSelected
                                        ? BaseColors.primary
                                        : Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    //
                                  ],
                                ),
                              ),
                              if (isSelected)
                                IconButton(
                                  onPressed: () {
                                    // Aksi ketika tombol edit ditekan (jika ada)
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Color(0xFF3B1D52),
                                  ),
                                )
                              else
                                Text(
                                  priceValue = 'Free',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3B1D52),
                                  ),
                                ),
                            ],
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 8),
                            const DottedLine(
                              direction: Axis.horizontal,
                              dashLength: 8,
                              dashColor: Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '${option['type'] == 'food' ? 'Food' : 'Drink'}: ${option['id']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  priceValue = 'Free',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3B1D52),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
