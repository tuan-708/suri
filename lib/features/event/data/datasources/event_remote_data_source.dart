import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_detail_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_register_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_register_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_event_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/scan_qr_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_special_info_model.dart';

abstract class EventRemoteDataSource {
  Future<EventDetailModel> getEventDetail(int payload);
  Future<List<EventModel>> getListEvents(ListEventsPayload payload);
  Future<EventRegisterModel> postEventRegister(EventRegisterPayload payload);
  Future<TicketInfoModel> getTicketInfo(int payload);
  Future<TicketSpecialInfoModel> getTicketSpecialInfo(int payload);
  Future<dynamic> postScanQrCode(ScanQrPayload payload);
}

class EventDataSourceImpl implements EventRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  EventDataSourceImpl();

  @override
  Future<EventDetailModel> getEventDetail(int payload) async {
    try {
      final response = await dioClient.get('/event/api/detail-event/$payload');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as Map<String, dynamic>;
        return EventDetailModel.fromJson(results);
      }
      throw const ServerException("Không tìm thấy sự kiện!");
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
        throw const ServerException("Không tìm thấy sự kiện!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      print(e);
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<EventModel>> getListEvents(ListEventsPayload payload) async {
    try {
      final response = await dioClient.get('/event/api/ListPagingByStatus',
          queryParameters: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;

        return results
            .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không tìm thấy sự kiện!");
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
        throw const ServerException("Không tìm thấy sự kiện!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<EventRegisterModel> postEventRegister(
      EventRegisterPayload payload) async {
    try {
      final response = await dioClient.post('/eventAccount/api/add-event',
          data: payload.toJson());

      if (response.data["status"] == "201" &&
          response.data["message"] == "CREATED") {
        final results = response.data["data"][0] as Map<String, dynamic>;
        return EventRegisterModel.fromJson(results);
      }

      throw const ServerException("Đăng ký sự kiện thất bại!");
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
        throw const ServerException("Đăng ký sự kiện thất bại!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<TicketInfoModel> getTicketInfo(int payload) async {
    try {
      final response = await dioClient
          .get('/eventaccount/app/api/detail-event-account/$payload');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as Map<String, dynamic>;
        return TicketInfoModel.fromJson(results);
      }
      throw const ServerException("Không tìm vé mời!");
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
        throw const ServerException("Không tìm vé mời!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<dynamic> postScanQrCode(ScanQrPayload payload) async {
    try {
      final response = await dioClient
          .post('/eventAccountCheckin/api/ScanQRCode', data: payload.toJson());
      // Dành cho tham gia sự kiện
      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return "Quét Qr tham gia sự kiện thành công!";
      }

      if (response.data["status"] == "400") {
        if (response.data["message"] == "GIFT_NOTFOUND") {
          throw const ServerException("Không tìm thấy phần quà!");
        } else if (response.data["message"] == "TIME_NOT_YET") {
          throw const ServerException("Chưa đến thời gian điểm danh nhận quà!");
        } else {
          throw const ServerException("Quét mã Qr thất bại!");
        }
      }

      // Dành cho quét quà
      if (response.data["status"] == "200") {
        return "Đã quét quà thành công";
      }

      if (response.data["status"] == "204") {
        throw const ServerException("Phần quà đã được quét trước đó");
      }

      throw const ServerException("Qúet mã sự kiện thất bại!");

      // if (response.data["status"] == "205") {
      //   throw const ServerException(
      //       "Bạn chưa thể check-in tại gian hàng do thời gian đăng ký chưa đủ 30 phút. Vui lòng thử lại sau");
      // }
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
        throw const ServerException("Qúet mã sự kiện thất bại!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<TicketSpecialInfoModel> getTicketSpecialInfo(int payload) async {
    try {
      final response = await dioClient
          .get('/eventAccount/app/api/detail-event-special/$payload');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as Map<String, dynamic>;
        return TicketSpecialInfoModel.fromJson(results);
      }
      throw const ServerException("Không tìm vé mời đặc biệt!");
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
        throw const ServerException("Không tìm vé mời!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }
}
