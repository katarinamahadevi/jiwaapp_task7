class UserModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? rememberToken;
  final String createdAt;
  final String updatedAt;
  final String gender;
  final String dateOfBirth;
  final String region;
  final String job;
  final String phoneNumber;
  final String referralCode;
  final String? referredBy;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.dateOfBirth,
    required this.region,
    required this.job,
    required this.phoneNumber,
    required this.referralCode,
    this.referredBy,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      rememberToken: json['remember_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      region: json['region'],
      job: json['job'],
      phoneNumber: json['phone_number'],
      referralCode: json['referral_code'],
      referredBy: json['referred_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'remember_token': rememberToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'region': region,
      'job': job,
      'phone_number': phoneNumber,
      'referral_code': referralCode,
      'referred_by': referredBy,
    };
  }
}
