import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/remote/dio/logging_interceptor.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';

import 'package:http_parser/http_parser.dart';

class DioClient {
  GetIt sl = GetIt.instance;
  Dio? dio;
  String? token;
  LoggingInterceptor? loggingInterceptor;
  // final RefreshTokenUtil refreshTokenUtil = RefreshTokenUtil();

  DioClient() {
    init();
  }

  ///
  /// Init dio.
  ///
  Future<void> init() async {
    final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;
    dio = Dio();
    dio!
      ..options.baseUrl = BASE_URL
      ..options.connectTimeout = 60 * 1000
      ..options.receiveTimeout = 60 * 1000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken'
      };
    dio!.interceptors.add(sl.get<LoggingInterceptor>());
  }

  ///
  /// Refresh token.
  ///
  Future<void> refreshToken() async {
    final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;
    dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwtToken'
    };
  }

  ///
  /// Call lại hàm khi token hết hạn gọi không được.
  ///
  Future<Response<dynamic>> reTry(RequestOptions resquestOption) async {
    try {
      final method = resquestOption.method;

      if (method == 'PUT') {
        return await dio!.put(resquestOption.path, data: resquestOption.data);
      }
      if (method == 'GET') {
        final data = await dio!.get(resquestOption.path);
        return data;
      }
      if (method == 'DELETE') {
        return await dio!
            .delete(resquestOption.path, data: resquestOption.data);
      }
      return await dio!.post(resquestOption.path, data: resquestOption.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Làm mới token khi hết hạn.
  ///
  Future<bool> refreshTokenExpiration() async {
    final refreshTokenSaved = sl<SharedPreferenceHelper>().refreshToken;
    dio!.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    // Trường hợp đang sử dụng mà refresh token hết hạn.
    // print("Hạn sử dụng: ${JwtDecoder.getExpirationDate(refreshTokenSaved)}");
    try {
      if (JwtDecoder.isExpired(refreshTokenSaved)) {
        goToLogin();
        return false;
      }
    } catch (e) {
      goToLogin();
      return false;
    }

    final response = await dio!.put(
      '/auth/refresh-token',
      data: {'refreshToken': refreshTokenSaved},
    );
    final results = response.data as dynamic;

    sl<SharedPreferenceHelper>().setJwtToken(results['accessToken'].toString());
    sl<SharedPreferenceHelper>()
        .setRefreshToken(results['refreshToken'].toString());
    await refreshToken();
    return true;
  }

  ///
  /// Refresh token khi mới vào app.
  ///
  Future<void> callApiRefreshToken() async {
    /// Bắt try catch khi gặp lỗi app vẫn chạy bình thường.
    try {
      final refreshTokenSaved = sl<SharedPreferenceHelper>().refreshToken;
      dio!.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final response = await dio!.put(
        '/auth/refresh-token',
        data: {'refreshToken': refreshTokenSaved},
      );
      final results = response.data as dynamic;

      sl<SharedPreferenceHelper>()
          .setJwtToken(results['accessToken'].toString());
      sl<SharedPreferenceHelper>()
          .setRefreshToken(results['refreshToken'].toString());
      await refreshToken();
    } catch (e) {
      // Do something.
    }
  }

  ///
  /// Trường hợp token hết hạn không refresh được.
  ///
  void goToLogin() {
    sl<SharedPreferenceHelper>().removeJwtToken();
    sl<SharedPreferenceHelper>().setLogged(status: false);
    sl<SharedPreferenceHelper>().removeRefreshToken();
  }

  ///
  /// Refresh token.
  ///
  // Future<void> refreshToken({String? url}) async {
  //   final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;
  //   dio = Dio();
  //   dio!
  //     ..options.baseUrl = url ?? app_constants.BASE_URL
  //     ..options.connectTimeout = 60 * 1000
  //     ..options.receiveTimeout = 60 * 1000
  //     ..httpClientAdapter
  //     ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $jwtToken'};
  //   dio!.interceptors.add(sl.get<LoggingInterceptor>());
  // }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    init();
    try {
      final response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    init();
    try {
      final response = await dio!.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    init();
    try {
      final response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    init();
    try {
      final response = await dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadImages(
    String uri, {
    List<File>? files,
    XFile? pickFile,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    init();
    try {
      // final arrayFiles = [];
      // for (var i = 0; i < files!.length; i++) {
      //   arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      // }
      final FormData formData = FormData.fromMap({
        'fileImage': await MultipartFile.fromFile(pickFile!.path,
            filename: pickFile.path.split('/').last,
            contentType: MediaType('image', 'png'))
      });

      final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;

      final response = await dio!.post(
        uri,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $jwtToken',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive'
          },
        ),
        onSendProgress: (int sent, int total) => {print('$sent $total')},
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postSingleFile(
    String uri, {
    XFile? pickFile,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    init();
    try {
      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(pickFile!.path,
            filename: pickFile.path.split('/').last,
            contentType: MediaType('image', 'jpeg'))
      });

      final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;

      final response = await dio!.post(
        uri,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $jwtToken',
          },
        ),
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadFiles(
    String uri, {
    required List<PlatformFile> files,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    init();
    try {
      final arrayFiles = [];
      for (var i = 0; i < files.length; i++) {
        arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      }

      final FormData formData = FormData.fromMap({'files': arrayFiles});

      final response = await dio!.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}
