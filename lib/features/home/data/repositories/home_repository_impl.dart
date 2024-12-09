import 'package:suri_checking_event_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:suri_checking_event_app/features/home/domain/repositories/home_repositories.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl({required this.homeRemoteDataSource});
}
