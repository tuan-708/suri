import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_profile_payload.dart';
import 'package:suri_checking_event_app/features/user/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, bool>> postDeleteAccount() async {
    try {
      final user = await userRemoteDataSource.postDeleteAccount();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChangePasswordPayload>> postChangePassword(
      ChangePasswordPayload payload) async {
    try {
      final user = await userRemoteDataSource.postChangePassword(payload);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> postSingleFile(XFile pickFile) async {
    try {
      final url = await userRemoteDataSource.postSingleFile(pickFile);
      if (!StringValid.nullOrEmpty(url)) {
        return right(url);
      }
      return left(Failure("FAILD"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> postChangeProfile(
      ChangeProfilePayload payload) async {
    try {
      final url = await userRemoteDataSource.postChangeProfile(payload);
      if (!StringValid.nullOrEmpty(url)) {
        return right(url);
      }
      return left(Failure("FAILD"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getVoteRemains(int payload) async {
    try {
      final count = await userRemoteDataSource.getVoteRemains(payload);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
