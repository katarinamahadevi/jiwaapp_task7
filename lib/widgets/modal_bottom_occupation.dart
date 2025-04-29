import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class ModalBottomOccupation extends StatefulWidget {
  final List<String> occupation;
  final String? initialValue;
  final Function(String) onOccupationSelected;

  const ModalBottomOccupation({
    Key? key,
    required this.occupation,
    this.initialValue,
    required this.onOccupationSelected,
  }) : super(key: key);

  @override
  State<ModalBottomOccupation> createState() => _ModalbottomOccupationState();
}

class _ModalbottomOccupationState extends State<ModalBottomOccupation> {
  String? _selectedOccupation;

  @override
  void initState() {
    super.initState();
    _selectedOccupation = widget.initialValue;
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Pekerjaan',
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

          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.occupation.length,
              separatorBuilder:
                  (context, index) => const Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: BaseColors.border,
                  ),
              itemBuilder: (context, index) {
                final Occupation = widget.occupation[index];
                final isSelected = Occupation == _selectedOccupation;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    Occupation,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                  trailing: Radio<String>(
                    value: Occupation,
                    groupValue: _selectedOccupation,
                    onChanged: (value) {
                      setState(() {
                        _selectedOccupation = value;
                      });
                    },
                    activeColor: BaseColors.primary,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedOccupation = Occupation;
                    });
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    _selectedOccupation != null
                        ? () {
                          widget.onOccupationSelected(_selectedOccupation!);
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
