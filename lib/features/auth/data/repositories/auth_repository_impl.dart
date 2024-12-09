import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_apple_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_google_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/send_otp_payload.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/register_entity.dart';
import 'package:suri_checking_event_app/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> postLogin(LoginPayload payload) async {
    try {
      final profile = await authRemoteDataSource.postLogin(payload);
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> postRegister(
      RegisterPayload payload) async {
    try {
      final profile = await authRemoteDataSource.postRegister(payload);
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> postForgotPassword(String payload) async {
    try {
      final response = await authRemoteDataSource.postForgotPassword(payload);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> postSendOtp(SendOTPPayload payload) async {
    try {
      final response = await authRemoteDataSource.postSendOtp(payload);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> postLoginGoogle(
      LoginGooglePayload payload) async {
    try {
      final profile = await authRemoteDataSource.postLoginGoogle(payload);
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> postLoginApple(
      LoginApplePayload payload) async {
    try {
      final profile = await authRemoteDataSource.postLoginApple(payload);
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getOtpRegister(String payload) async {
    try {
      final res = await authRemoteDataSource.getOtpRegister(payload);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
