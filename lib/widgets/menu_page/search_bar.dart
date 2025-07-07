import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';

//SEARCHBAR DI MENU

Widget buildSearchBar() {
  return Container(
    color: BaseColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: CustomSearchBar(
      hintText: 'Search menu...',
      icon: Icons.search_sharp,
      iconColor: BaseColors.secondary,
      backgroundColor: Colors.white,
      textColor: Colors.grey,
      onChanged: (value) {
        print('Search input: $value');
      },
    ),
  );
}
