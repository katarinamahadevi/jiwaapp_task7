import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class ModalbottomPickerdate extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;

  const ModalbottomPickerdate({
    Key? key,
    required this.onDateSelected,
    this.initialDate,
  }) : super(key: key);

  @override
  State<ModalbottomPickerdate> createState() =>
      _ModalbottomPickerdateState();
}

class _ModalbottomPickerdateState
    extends State<ModalbottomPickerdate> {
  late DateTime _selectedDate;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final int _startYear = DateTime.now().year - 100;
  final int _endYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();

    _dayController = FixedExtentScrollController(
      initialItem: _selectedDate.day - 1,
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedDate.month - 1,
    );
    _yearController = FixedExtentScrollController(
      initialItem: _selectedDate.year - _startYear,
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _getDaysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildPicker(
                    _dayController,
                    List.generate(
                      31,
                      (index) => (index + 1).toString().padLeft(2, '0'),
                    ),
                    (index) {
                      final day = index + 1;
                      final month = _selectedDate.month;
                      final year = _selectedDate.year;
                      final maxDays = _getDaysInMonth(month - 1, year);
                      final validDay = day <= maxDays ? day : maxDays;

                      setState(() {
                        _selectedDate = DateTime(year, month, validDay);
                      });
                    },
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: _buildPicker(_monthController, _months, (index) {
                    final day = _selectedDate.day;
                    final month = index + 1;
                    final year = _selectedDate.year;

                    final maxDays = _getDaysInMonth(month - 1, year);
                    final validDay = day <= maxDays ? day : maxDays;

                    setState(() {
                      _selectedDate = DateTime(year, month, validDay);
                    });

                    if (validDay != day) {
                      _dayController.jumpToItem(validDay - 1);
                    }
                  }),
                ),

                // Years
                Expanded(
                  child: _buildPicker(
                    _yearController,
                    List.generate(
                      _endYear - _startYear + 1,
                      (index) => (_startYear + index).toString(),
                    ),
                    (index) {
                      final day = _selectedDate.day;
                      final month = _selectedDate.month;
                      final year = _startYear + index;

                      final maxDays = _getDaysInMonth(month - 1, year);
                      final validDay = day <= maxDays ? day : maxDays;

                      setState(() {
                        _selectedDate = DateTime(year, month, validDay);
                      });

                      if (validDay != day) {
                        _dayController.jumpToItem(validDay - 1);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  widget.onDateSelected(_selectedDate);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      BaseColors
                          .primary, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPicker(
    FixedExtentScrollController controller,
    List<String> items,
    Function(int) onSelectedItemChanged,
  ) {
    return CupertinoPicker(
      scrollController: controller,
      itemExtent: 40,
      diameterRatio: 1.5,
      selectionOverlay: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      ),
      onSelectedItemChanged: onSelectedItemChanged,
      children:
          items
              .map(
                (item) => Center(
                  child: Text(item, style: const TextStyle(fontSize: 18)),
                ),
              )
              .toList(),
    );
  }
}



