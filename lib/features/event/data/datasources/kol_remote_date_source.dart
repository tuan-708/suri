import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/kol_detail_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_paging_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/remaining_votes_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/searching_kol_payload.dart';

abstract class KOLRemoteDataSource {
  Future<List<ListKOLModel>> getListTop3KOL();
  Future<List<HistoryVoteModel>> getListHistoryVote(HistoryVotePayload payload);
  Future<RemainingVotesModel> getRemainingVotes();
  Future<bool> postVoteKol(int payload);
  Future<List<KOLDetailModel>> getListKOLPaging(ListKOLPagingPayload payload);
  Future<List<KOLDetailModel>> getLitKOLSearching(SearchingKOLPayload payload);
}

class KOLDataSourceImpl implements KOLRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  KOLDataSourceImpl();

  @override
  Future<List<ListKOLModel>> getListTop3KOL() async {
    try {
      final response = await dioClient.get('/KolList/api/GetTop3Kols');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;
        return results
            .map((e) => ListKOLModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không tìm KOL's!");
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
        throw const ServerException("Không tìm KOL's!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<HistoryVoteModel>> getListHistoryVote(
      HistoryVotePayload payload) async {
    try {
      final response = await dioClient.get(
          '/votingHistory/api/listPaging-history-vote-by-id/${payload.kolId}?pageIndex=${payload.pageIndex}&pageSize=${payload.pageSize}');

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"][0] as List<dynamic>;
        return results
            .map((e) => HistoryVoteModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không có lịch sử vote!");
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
        throw const ServerException("Không có lịch sử vote!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<RemainingVotesModel> getRemainingVotes() async {
    try {
      final response = await dioClient.get('/kolVote/api/remaining-votes');
      if (response.statusCode == 200) {
        final results = response.data as Map<String, dynamic>;

        return RemainingVotesModel.fromJson(results);
      }
      throw const ServerException("Lấy số lượng vote trong ngày thất bại");
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
        throw const ServerException("Lấy số lượng vote trong ngày thất bại");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<bool> postVoteKol(int payload) async {
    try {
      final response = await dioClient
          .post('/kolVote/api/vote-kol', data: {"AccountKolId": payload});

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        return true;
      }
      throw const ServerException("Bạn đã hết số lượng vote trong ngày");
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
        throw const ServerException("Bạn đã hết số lượng vote trong ngày");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<KOLDetailModel>> getListKOLPaging(
      ListKOLPagingPayload payload) async {
    try {
      final response = await dioClient.get('/KolList/api/listPaging2',
          queryParameters: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;
        return results
            .map((e) => KOLDetailModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không tìm KOL's!");
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
        throw const ServerException("Không tìm KOL's!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }

  @override
  Future<List<KOLDetailModel>> getLitKOLSearching(
      SearchingKOLPayload payload) async {
    try {
      final response = await dioClient.get('/KolList/api/SearchApp',
          queryParameters: payload.toJson());

      if (response.data["status"] == "200" &&
          response.data["message"] == "SUCCESS") {
        final results = response.data["data"] as List<dynamic>;
        return results
            .map((e) => KOLDetailModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw const ServerException("Không tìm KOL's!");
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
        throw const ServerException("Không tìm KOL's!");
      } else {
        throw ServerException("Đã xảy ra lỗi khi kết nối đến máy chủ");
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw ServerException("$e");
    }
  }
}
