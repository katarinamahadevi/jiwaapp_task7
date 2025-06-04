class NotificationModel {
  final String type;
  final String orderCode;
  final String title;
  final String message;
  final String rewardType;
  final int value;
  final String date;
  final String time;

  NotificationModel({
    required this.type,
    required this.orderCode,
    required this.title,
    required this.message,
    required this.rewardType,
    required this.value,
    required this.date,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      type: json['type'],
      orderCode: json['order_code'],
      title: json['title'],
      message: json['message'],
      rewardType: json['reward_type'],
      value: json['value'],
      date: json['date'],
      time: json['time'],
    );
  }
}
