class AddressModel {
  final int id;
  final int userId;
  final String label;
  final String address;
  final double latitude;
  final double longitude;
  final String note;
  final String recipientName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneNumber;

  AddressModel({
    required this.id,
    required this.userId,
    required this.label,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.note,
    required this.recipientName,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    userId: json["user_id"],
    label: json["label"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    note: json["note"],
    recipientName: json["recipient_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "label": label,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "note": note,
    "recipient_name": recipientName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "phone_number": phoneNumber,
  };
}
