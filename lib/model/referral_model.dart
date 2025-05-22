class ReferralModel {
  final int? total;
  final List<ReferralByModel>? friends;

  ReferralModel({this.total, this.friends});

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    print('Parsing ReferralModel from JSON: $json');

    try {
      final data = json['data'] as Map<String, dynamic>?;

      if (data == null) {
        throw Exception("Missing 'data' field in response.");
      }

      int? total = data['total'] as int?;
      List<dynamic>? friendsData = data['friends'] as List<dynamic>?;

      List<ReferralByModel> friends =
          friendsData != null
              ? friendsData
                  .map(
                    (item) =>
                        ReferralByModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList()
              : [];

      return ReferralModel(total: total ?? friends.length, friends: friends);
    } catch (e) {
      print('Error parsing ReferralModel: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'friends': friends?.map((x) => x.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ReferralModel(total: $total, friends: ${friends?.length})';
  }
}

class ReferralByModel {
  final String name;
  final String status;
  final String? email;
  final String? phone;
  final DateTime? joinedAt;

  ReferralByModel({
    required this.name,
    required this.status,
    this.email,
    this.phone,
    this.joinedAt,
  });

  factory ReferralByModel.fromJson(Map<String, dynamic> json) {
    print('Parsing ReferralByModel from JSON: $json');

    try {
      // Handle different possible field names
      String name = '';
      if (json.containsKey('name')) {
        name = json['name'] as String? ?? '';
      } else if (json.containsKey('full_name')) {
        name = json['full_name'] as String? ?? '';
      } else if (json.containsKey('username')) {
        name = json['username'] as String? ?? '';
      }

      String status = '';
      if (json.containsKey('status')) {
        status = json['status'] as String? ?? 'inactive';
      } else if (json.containsKey('is_active')) {
        bool isActive = json['is_active'] as bool? ?? false;
        status = isActive ? 'active' : 'inactive';
      }

      return ReferralByModel(
        name: name,
        status: status,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        joinedAt:
            json['joined_at'] != null
                ? DateTime.tryParse(json['joined_at'] as String)
                : null,
      );
    } catch (e) {
      print('Error parsing ReferralByModel: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'email': email,
      'phone': phone,
      'joined_at': joinedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ReferralByModel(name: $name, status: $status)';
  }
}
