class CourierModel {
  final String code;
  final String name;
  final int fee;

  CourierModel({
    required this.code,
    required this.name,
    required this.fee,
  });

  factory CourierModel.fromJson(Map<String, dynamic> json) {
    return CourierModel(
      code: json['code'],
      name: json['name'],
      fee: json['fee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'fee': fee,
    };
  }
}
