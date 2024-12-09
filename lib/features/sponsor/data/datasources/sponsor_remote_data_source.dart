import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_sponsor_payload.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/sponsor_detail_model.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/sponsor_model.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/store_checkin_model.dart';

abstract class SponsorRemoteDataSource {
  Future<List<SponsorModel>> getListSponsors(ListSponsorsPayload payload);
  Future<SponsorDetailModel> getSponsorDetail(int payload);
  Future<List<StoreCheckinModel>> getListStoreCheckin(int payload);
}

class SponsorDataSourceImpl implements SponsorRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  SponsorDataSourceImpl();

  @override
  Future<List<SponsorModel>> getListSponsors(
      ListSponsorsPayload payload) async {
    try {
      final response = await dioClient.get('/sponsor/api/listPaging',
          queryParameters: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;

        return results
            .map((e) => SponsorModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không tìm thấy nhà tài trợ!");
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
        throw const ServerException("Không tìm thấy nhà tài trợ!");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<SponsorDetailModel> getSponsorDetail(int payload) async {
    try {
      final response = await dioClient.get('/sponsor/api/detail/$payload');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as Map<String, dynamic>;

        return SponsorDetailModel.fromJson(results);
      }
      throw const ServerException("Không tìm thấy nhà tài trợ!");
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
        throw const ServerException("Không tìm thấy nhà tài trợ!");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<StoreCheckinModel>> getListStoreCheckin(int payload) async {
    try {
      final response = await dioClient.get(
        '/store/api/list-store-checkin?eventId=$payload',
      );

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as List<dynamic>;

        return results
            .map((e) => StoreCheckinModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không có cửa hàng!");
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
        throw const ServerException("Không có cửa hàng!");
      } else {
        throw const ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      print(e);
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }
}
