import 'package:dio/dio.dart';
import 'package:source_base/core/api/api_endpoints.dart';
import 'package:source_base/core/api/dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  // Phương thức đăng nhập
  Future<Response> login(String email, String password) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức đăng ký
  Future<Response> register(String name, String email, String password) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức lấy thông tin người dùng
  Future<Response> getUserProfile() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.userProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức cập nhật thông tin người dùng
  Future<Response> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.updateProfile,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Thêm các phương thức API khác tại đây
}
