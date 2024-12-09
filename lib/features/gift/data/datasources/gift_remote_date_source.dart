import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/features/gift/data/models/event_gift_modal.dart';
import 'package:suri_checking_event_app/features/gift/data/models/gift_account_model.dart';
import 'package:suri_checking_event_app/features/gift/data/models/gift_model.dart';

abstract class GiftRemoteDataSource {
  Future<List<GiftModel>> getListGiftOfEvent(int payload);
  Future<List<GiftAccountModel>> getListGiftOfAccount();
  Future<List<EventGiftModel>> getListEventGift(int payload);
}

class GiftDataSourceImpl implements GiftRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  GiftDataSourceImpl();

  @override
  Future<List<GiftModel>> getListGiftOfEvent(int payload) async {
    try {
      final response =
          await dioClient.get('/eventgift/api/list-by-event/$payload');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;
        return results
            .map((e) => GiftModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Sự kiện hiện tại chưa có quà");
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
        throw const ServerException("Sự kiện hiện tại chưa có quà");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<GiftAccountModel>> getListGiftOfAccount() async {
    try {
      final response = await dioClient.get('/AccountGift/api/AccountGift');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;
        return results
            .map((e) => GiftAccountModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Hiện tại bạn có quà");
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
        throw const ServerException("Hiện tại bạn có quà");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<EventGiftModel>> getListEventGift(int payload) async {
    try {
      final response =
          await dioClient.get('/eventGift/api/my-gift-event/$payload');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;
        return results
            .map((e) => EventGiftModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Bạn chưa có quà sự kiện!");
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
        throw const ServerException("Sự kiện hiện tại chưa có quà");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }
}
