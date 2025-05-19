import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/model/address_model.dart';
import 'package:jiwaapp_task7/services/api_client.dart';

class AddressService {
  final Dio _dio;

  AddressService(ApiClient apiClient) : _dio = apiClient.dio;

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _dio.get('/auth/addresses');
      if (response.statusCode == 200) {
        final List<dynamic> addressesJson = response.data['data'];
        return addressesJson
            .map((json) => AddressModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load addresses');
      }
    } catch (e) {
      throw Exception('Error fetching addresses: $e');
    }
  }

  Future<AddressModel> addAddress(Map<String, dynamic> addressData) async {
    try {
      final response = await _dio.post('/auth/add-address', data: addressData);
      if (response.statusCode == 201) {
        return AddressModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to add address');
      }
    } catch (e) {
      throw Exception('Error adding address: $e');
    }
  }

  Future<AddressModel> updateAddress(
    int id,
    Map<String, dynamic> addressData,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/update-address/$id',
        data: addressData,
      );
      if (response.statusCode == 200) {
        return AddressModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update address');
      }
    } catch (e) {
      throw Exception('Error updating address: $e');
    }
  }

  Future<bool> deleteAddress(int id) async {
    try {
      final response = await _dio.delete('/auth/delete-address/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete address');
      }
    } catch (e) {
      throw Exception('Error deleting address: $e');
    }
  }
}
