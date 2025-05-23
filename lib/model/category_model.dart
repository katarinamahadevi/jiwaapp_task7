import 'package:jiwaapp_task7/model/menu_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MenuModel> products;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type, 
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '', 
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      products: (json['products'] as List?)
              ?.map((product) => MenuModel.fromJson(product))
              .toList() ??
          [],
    );
  }
}
