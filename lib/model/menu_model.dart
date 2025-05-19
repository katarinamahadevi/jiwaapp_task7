class MenuModel {
  final int id;
  final int categoryId;
  final String name;
  final String price;
  final String originalPrice;
  final String imageUrlText;
  final DateTime createdAt;
  final DateTime updatedAt;

  MenuModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrlText,

    required this.createdAt,
    required this.updatedAt,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '0',
      originalPrice: json['original_price'] ?? '0',
      imageUrlText: json['image_url_text'],

      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now(),
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : DateTime.now(),
    );
  }
}
