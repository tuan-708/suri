import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_profile_payload.dart';

abstract class UserRemoteDataSource {
  Future<bool> postDeleteAccount();
  Future<ChangePasswordPayload> postChangePassword(
      ChangePasswordPayload payload);
  Future<dynamic> postSingleFile(XFile? pickFile);
  Future<bool> postChangeProfile(ChangeProfilePayload payload);
  Future<int> getVoteRemains(int payload);
}

class UserDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  UserDataSourceImpl();

  @override
  Future<bool> postDeleteAccount() async {
    try {
      final response = await dioClient.delete(
        '/account/api/DeleteAccountId',
      );

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return true;
      }
      throw const ServerException("Xóa tài khoản thất bại!");
    } on DioError catch (dioError) {
      // Bắt lỗi liên quan đến thư viện Dio
      if (dioError.type == DioErrorType.connectTimeout) {
        throw const ServerException(
            "Kết nối đến máy chủ thất bại, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.receiveTimeout) {
        throw const ServerException(
            "Máy chủ không phản hồi, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.response) {
        // Xử lý lỗi cụ thể từ phía server
        final statusCode = dioError.response?.statusCode;
        throw ServerException(
            "Lỗi từ máy chủ: ${dioError.response?.statusMessage} (Mã lỗi: $statusCode)");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<ChangePasswordPayload> postChangePassword(
      ChangePasswordPayload payload) async {
    try {
      final response = await dioClient.post('/account/api/change-password',
          data: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as Map<String, dynamic>;
        return ChangePasswordPayload.fromJson(results);
      }
      throw const ServerException("Thay đổi mật khẩu thất bại!");
    } on DioError catch (dioError) {
      // Bắt lỗi liên quan đến thư viện Dio
      if (dioError.type == DioErrorType.connectTimeout) {
        throw const ServerException(
            "Kết nối đến máy chủ thất bại, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.receiveTimeout) {
        throw const ServerException(
            "Máy chủ không phản hồi, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.response) {
        // Xử lý lỗi cụ thể từ phía server
        final statusCode = dioError.response?.statusCode;
        throw ServerException(
            "Lỗi từ máy chủ: ${dioError.response?.statusMessage} (Mã lỗi: $statusCode)");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<dynamic> postSingleFile(XFile? pickFile) async {
    try {
      final response = await dioClient
          .postSingleFile('/Account/api/ChangeAvatar', pickFile: pickFile);
      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return response.data["data"][0];
      }
    } on DioError catch (dioError) {
      // Bắt lỗi liên quan đến thư viện Dio
      if (dioError.type == DioErrorType.connectTimeout) {
        throw const ServerException(
            "Kết nối đến máy chủ thất bại, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.receiveTimeout) {
        throw const ServerException(
            "Máy chủ không phản hồi, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.response) {
        // Xử lý lỗi cụ thể từ phía server
        final statusCode = dioError.response?.statusCode;
        throw ServerException(
            "Lỗi từ máy chủ: ${dioError.response?.statusMessage} (Mã lỗi: $statusCode)");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<bool> postChangeProfile(ChangeProfilePayload payload) async {
    try {
      final response = await dioClient.post('/account/api/update-profile-app',
          data: payload.toJson());
      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return true;
      }

      if (response.data["status"] == "204") {
        throw const ServerException("Số điện thoại đã được sử dụng!");
      }
      if (response.data["status"] == "202") {
        throw const ServerException("Email đã được sử dụng!");
      }
      throw const ServerException("Thay đổi thông tin tài khoản thất bại!");
    } on DioError catch (dioError) {
      // Bắt lỗi liên quan đến thư viện Dio
      if (dioError.type == DioErrorType.connectTimeout) {
        throw const ServerException(
            "Kết nối đến máy chủ thất bại, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.receiveTimeout) {
        throw const ServerException(
            "Máy chủ không phản hồi, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.response) {
        // Xử lý lỗi cụ thể từ phía server
        final statusCode = dioError.response?.statusCode;
        throw ServerException(
            "Lỗi từ máy chủ: ${dioError.response?.statusMessage} (Mã lỗi: $statusCode)");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<int> getVoteRemains(int payload) async {
    try {
      final response = await dioClient.get(
        '/event/api/vote-remains/$payload',
      );
      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return response.data["data"][0];
      }

      throw const ServerException("Lỗi lấy lượt vote");
    } on DioError catch (dioError) {
      // Bắt lỗi liên quan đến thư viện Dio
      if (dioError.type == DioErrorType.connectTimeout) {
        throw const ServerException(
            "Kết nối đến máy chủ thất bại, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.receiveTimeout) {
        throw const ServerException(
            "Máy chủ không phản hồi, vui lòng thử lại sau.");
      } else if (dioError.type == DioErrorType.response) {
        // Xử lý lỗi cụ thể từ phía server
        final statusCode = dioError.response?.statusCode;
        throw ServerException(
            "Lỗi từ máy chủ: ${dioError.response?.statusMessage} (Mã lỗi: $statusCode)");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }
}
