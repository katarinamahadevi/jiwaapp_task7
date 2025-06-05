// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:jiwaapp_task7/theme/color.dart' show BaseColors;

// //TOGGLE JIWA POINT

// class ToggleCupertino extends StatefulWidget {
//   final bool value;
//   final ValueChanged<bool> onChanged;
//   final Color activeColor;
//   final Color inactiveColor;
//   final Color thumbColor;

//   const ToggleCupertino({
//     Key? key,
//     required this.value,
//     required this.onChanged,
//     this.activeColor = BaseColors.primary,
//     this.inactiveColor = const Color(0xFFE0E0E0),
//     this.thumbColor = Colors.white,
//   }) : super(key: key);

//   @override
//   State<ToggleCupertino> createState() => _ToggleCupertinoState();
// }

// class _ToggleCupertinoState extends State<ToggleCupertino> {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTheme(
//       data: CupertinoThemeData(primaryColor: widget.activeColor),
//       child: SizedBox(
//         height: 30, 
//         child: Transform.scale(
//           scale: 0.8, 
//           child: CupertinoSwitch(
//             value: widget.value,
//             onChanged: widget.onChanged,
//             activeColor: widget.activeColor,
//             trackColor: widget.inactiveColor,
//             thumbColor: widget.thumbColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
