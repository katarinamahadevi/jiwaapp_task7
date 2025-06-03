import 'package:jiwaapp_task7/model/menu_model.dart';

class CartItemModel {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final String note;
  final String createdAt;
  final String updatedAt;
  final MenuModel product;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? 0,
      cartId: json['cart_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      note: json['note'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      product: MenuModel.fromJson(json['product'] ?? {}),
    );
  }
}
