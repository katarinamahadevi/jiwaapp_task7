import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jiwaapp_task7/model/category_model.dart';

//KATEGORI

class CategoryListItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final bool isNew;
  final VoidCallback onTap;

  const CategoryListItem({
    Key? key,
    required this.category,
    required this.isSelected,
    this.isNew = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isSelected ? const Color(0xFFE56257) : Colors.transparent,
              width: 4.0,
            ),
          ),
          color: isSelected ? Colors.white : Colors.grey[100],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isNew)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B1D52),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shake(hz: 3, curve: Curves.easeInOut),
              ),
            Text(
              category.name,
              style: TextStyle(
                color: isSelected ? const Color(0xFFE56257) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
