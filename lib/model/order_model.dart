import 'package:jiwaapp_task7/model/cart_item_model.dart';

class OrderModel {
  final int id;
  final int? userId;
  final int? addressId;
  final String? orderCode;
  final String orderType;
  final String? courier;
  final int? deliveryFee;
  final String orderStatus;
  final int subtotalPrice;
  final int totalPrice;
  final String createdAt;
  final String updatedAt;
  final int itemCount;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId,
    this.addressId,
    this.orderCode,
    required this.orderType,
    this.courier,
    this.deliveryFee,
    required this.orderStatus,
    required this.subtotalPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.itemCount,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      orderCode: json['order_code'],
      orderType: json['order_type'],
      courier: json['courier'],
      deliveryFee:
          json['delivery_fee'] != null
              ? int.tryParse(json['delivery_fee'].toString())
              : null,
      orderStatus: json['order_status'],
      subtotalPrice: json['subtotal_price'],
      totalPrice:
          json['total_price'] is String
              ? int.tryParse(json['total_price']) ?? 0
              : (json['total_price'] ?? 0),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      itemCount: json['item_count'],
      items: List<CartItemModel>.from(
        json['items'].map((item) => CartItemModel.fromJson(item)),
      ),
    );
  }
}
