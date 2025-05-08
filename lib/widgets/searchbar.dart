import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    this.hintText = 'Search menu',
    this.icon = Icons.search,
    this.backgroundColor = Colors.white,
    this.iconColor = const Color(0xFF3B1D52),
    this.textColor = const Color(0xFFBDBDBD),
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  late Color _borderColor;

  @override
  void initState() {
    super.initState();
    _borderColor = const Color(0xFFE5E5E5);
    _controller.addListener(() {
      final isNotEmpty = _controller.text.isNotEmpty;
      setState(() {
        _borderColor =
            isNotEmpty ? BaseColors.primary : const Color(0xFFE5E5E5);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Icon(widget.icon, color: widget.iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: widget.textColor,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              style: TextStyle(color: widget.iconColor),
            ),
          ),
        ],
      ),
    );
  }
}
