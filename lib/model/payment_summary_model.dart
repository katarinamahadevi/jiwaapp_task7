class PaymentSummaryModel {
  final int subtotalPrice;
  final int deliveryFee;
  final int totalPrice;
  final int itemCount;

  PaymentSummaryModel({
    required this.subtotalPrice,
    required this.deliveryFee,
    required this.totalPrice,
    required this.itemCount,
  });

  factory PaymentSummaryModel.fromJson(Map<String, dynamic> json) {
    return PaymentSummaryModel(
      subtotalPrice: json['subtotal_price'] ?? 0,
      deliveryFee: json['delivery_fee'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
      itemCount: json['item_count'] ?? 0,
    );
  }
}
