import 'package:jiwaapp_task7/model/cart_item_model.dart';

class CartModel {
  final int id;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<CartItemModel> items;

  CartModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      items: List<CartItemModel>.from(json['items'].map((x) => CartItemModel.fromJson(x))),
    );
  }
}
