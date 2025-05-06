class UserModel {
  final String status;
  final String message;
  final UserData data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String gender;
  final DateTime dateOfBirth;
  final String region;
  final String job;
  final String referralCode;
  final dynamic referralBy;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.dateOfBirth,
    required this.region,
    required this.job,
    required this.referralCode,
    required this.referralBy,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        region: json["region"],
        job: json["job"],
        referralCode: json["referral_code"],
        referralBy: json["referral_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "gender": gender,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "region": region,
        "job": job,
        "referral_code": referralCode,
        "referral_by": referralBy,
      };
}