import 'package:get_it/get_it.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';

abstract class HomeRemoteDataSource {}

class HomeDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient = GetIt.I.get<DioClient>();

  HomeDataSourceImpl();
}
