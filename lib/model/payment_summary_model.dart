class PaymentSummaryModel {
  final int orderId;
  final int subtotalPrice;
  final int deliveryFee; 
  final int totalPrice;
  final int itemCount;
  final String orderType;
  final String courier;
  final String status;

  PaymentSummaryModel({
    required this.orderId,
    required this.subtotalPrice,
    required this.deliveryFee,
    required this.totalPrice,
    required this.itemCount,
    required this.orderType,
    required this.courier,
    required this.status,
  });

  factory PaymentSummaryModel.fromJson(Map<String, dynamic> json) {
    return PaymentSummaryModel(
      orderId: json['order_id'] ?? 0,
      subtotalPrice: json['subtotal_price'] ?? 0,
      deliveryFee: int.tryParse(json['delivery_fee'].toString()) ?? 0,
      totalPrice: json['total_price'] ?? 0,
      itemCount: json['item_count'] ?? 0,
      orderType: json['order_type'] ?? '',
      courier: json['courier'] ?? '',
      status: json['status'] ?? '',
    );
  }
}