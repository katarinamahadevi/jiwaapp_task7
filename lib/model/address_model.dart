class AddressModel {
  final int id;
  final int userId;
  final String label;
  final String address;
  final double latitude;
  final double longitude;
  final String note;
  final String recipientName;
  final String createdAt;
  final String updatedAt;

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
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      label: json['label'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      note: json['note'],
      recipientName: json['recipient_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'label': label,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'note': note,
      'recipient_name': recipientName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
