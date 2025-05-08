import 'package:jiwaapp_task7/model/category_model.dart';

class MenuResponseModel {
  final bool success;
  final String message;
  final List<CategoryModel> data;

  MenuResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MenuResponseModel.fromJson(Map<String, dynamic> json) {
    return MenuResponseModel(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}
