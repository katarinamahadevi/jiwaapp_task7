import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pickerdate.dart';

void showFilterOrderBottomSheet(BuildContext context) {
  final Map<String, bool> checkboxStates = {
    "Take Away": false,
    "Dine In": false,
    "Delivery": false,
    "Selesai": false,
    "Dibatalkan": false,
  };

  // Add date controllers and selected date variables
  final TextEditingController _startDateController = TextEditingController(
    text: "30/04/2024",
  );
  final TextEditingController _endDateController = TextEditingController(
    text: "30/04/2025",
  );
  DateTime? _selectedStartDate = DateTime(2024, 4, 30);
  DateTime? _selectedEndDate = DateTime(2025, 4, 30);

  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final mediaQuery = MediaQuery.of(context);
          final screenHeight = mediaQuery.size.height;

          return SizedBox(
            height: screenHeight * 0.7,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDragIndicator(),
                        _buildSectionTitle("Metode Pengiriman"),
                        _buildCheckbox("Take Away", checkboxStates, setState),
                        _buildCheckbox("Dine In", checkboxStates, setState),
                        _buildCheckbox("Delivery", checkboxStates, setState),
                        const Divider(height: 30),
                        _buildSectionTitle("Status Pesanan"),
                        _buildCheckbox("Selesai", checkboxStates, setState),
                        _buildCheckbox("Dibatalkan", checkboxStates, setState),
                        const Divider(height: 30),
                        _buildSectionTitle("Periode Pesanan"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showBirthDatePickerModal(
                                    context,
                                    initialDate: _selectedStartDate,
                                    onDateSelected: (DateTime date) {
                                      setState(() {
                                        _selectedStartDate = date;
                                        _startDateController.text = DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(date);
                                      });
                                    },
                                  );
                                },
                                child: _buildDateField(
                                  "Start",
                                  _startDateController.text,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("-"),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showBirthDatePickerModal(
                                    context,
                                    initialDate: _selectedEndDate,
                                    onDateSelected: (DateTime date) {
                                      setState(() {
                                        _selectedEndDate = date;
                                        _endDateController.text = DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(date);
                                      });
                                    },
                                  );
                                },
                                child: _buildDateField(
                                  "End",
                                  _endDateController.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                // Tombol bawah
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                for (var key in checkboxStates.keys) {
                                  checkboxStates[key] = false;
                                }
                                // Reset dates to default values
                                _startDateController.text = "30/04/2024";
                                _endDateController.text = "30/04/2025";
                                _selectedStartDate = DateTime(2024, 4, 30);
                                _selectedEndDate = DateTime(2025, 4, 30);
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Reset Filter"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              print("Filter dipilih: $checkboxStates");
                              print(
                                "Date range: ${_startDateController.text} - ${_endDateController.text}",
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: BaseColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Simpan"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Helper widgets

Widget _buildDragIndicator() {
  return Center(
    child: Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildCheckbox(
  String title,
  Map<String, bool> states,
  void Function(void Function()) setState,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Checkbox(
        value: states[title],
        activeColor: BaseColors.primary,
        onChanged: (value) {
          setState(() {
            states[title] = value ?? false;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ],
  );
}

Widget _buildDateField(String label, String date) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: Colors.black,
        ),
      ],
    ),
  );
}

// Using the exact same showBirthDatePickerModal from RegisterPage
void showBirthDatePickerModal(
  BuildContext context, {
  required Function(DateTime) onDateSelected,
  DateTime? initialDate,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => ModalbottomPickerdate(
          onDateSelected: onDateSelected,
          initialDate: initialDate,
        ),
  );
}
