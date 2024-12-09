import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_apple_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_google_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/profile_model.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_model.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/send_otp_payload.dart';

abstract class AuthRemoteDataSource {
  Future<ProfileModel> postLogin(LoginPayload payload);
  Future<ProfileModel> postLoginGoogle(LoginGooglePayload payload);
  Future<ProfileModel> postLoginApple(LoginApplePayload payload);
  Future<RegisterModel> postRegister(RegisterPayload payload);
  Future<bool> postForgotPassword(String payload);
  Future<bool> postSendOtp(SendOTPPayload payload);
  Future<bool> getOtpRegister(String payload);
}

class AuthDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  AuthDataSourceImpl();

  @override
  Future<ProfileModel> postLogin(LoginPayload payload) async {
    try {
      final response =
          await dioClient.post('/account/api/login', data: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return ProfileModel.fromJson(
            response.data["resources"] as Map<String, dynamic>);
      }
      throw const ServerException("Tài khoản hoặc mật khẩu không chính xác");
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
        throw const ServerException("Tài khoản hoặc mật khẩu không chính xác");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<RegisterModel> postRegister(RegisterPayload payload) async {
    try {
      final response =
          await dioClient.post('/account/api/register', data: payload.toJson());

      if (response.data["status"] == "201" &&
          response.data["message"] == "SUCCESS") {
        return RegisterModel.fromJson(
            response.data["resources"] as Map<String, dynamic>);
      }
      if (response.data["status"] == "400" &&
          response.data["message"] == "OTP_NOT_CORRECT") {
        throw const ServerException("OTP không hợp lệ");
      }
      if (response.data["status"] == "202" &&
          response.data["message"] == "EMAILEXIST") {
        throw const ServerException("Email đã được đăng ký!");
      }

      throw const ServerException("Đăng ký tài khoản không thành công!");
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
        throw const ServerException("Đăng ký tài khoản không thành công!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<bool> postForgotPassword(String payload) async {
    try {
      final response = await dioClient.get(
        '/Account/api/forgot-password-by-user?value=$payload',
      );

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return true;
      }
      throw const ServerException("Lỗi gửi code email!");
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
        throw const ServerException("Lỗi gửi code email!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<bool> postSendOtp(SendOTPPayload payload) async {
    try {
      final response = await dioClient.post(
          '/Account/api/change-password-by-forgot',
          data: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return true;
      }
      throw const ServerException("Đã có lỗi xảy ra, vui lòng thử lại sau");
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
        throw const ServerException("Đã có lỗi xảy ra, vui lòng thử lại sau");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<ProfileModel> postLoginGoogle(LoginGooglePayload payload) async {
    try {
      final response = await dioClient.post('/Account/api/SigninWithGoogle',
          data: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return ProfileModel.fromJson(
            response.data["resources"] as Map<String, dynamic>);
      }
      throw const ServerException("Đăng nhập không thành công!");
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
        throw const ServerException("Đăng nhập không thành công!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<ProfileModel> postLoginApple(LoginApplePayload payload) async {
    try {
      final response = await dioClient.post('/Account/api/SigninWithAppleId',
          data: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return ProfileModel.fromJson(
            response.data["resources"] as Map<String, dynamic>);
      }
      throw const ServerException("Đăng nhập không thành công!");
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
        throw const ServerException("Đăng nhập không thành công!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<bool> getOtpRegister(String payload) async {
    try {
      final response = await dioClient.get(
        '/Account/api/Send-Otp-register?value=$payload',
      );

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return true;
      }
      if (response.data["status"] == "400" &&
          response.data["message"] == "EMAIL_EXIST") {
        throw const ServerException(
            "Email đã tồn tại, vui lòng thử email khác");
      }

      throw const ServerException("Gửi Otp thất bại, vui lòng thử lại sau!");
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
        throw const ServerException("Đã có lỗi xảy ra, vui lòng thử lại sau");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }
}
