import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_apple_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_google_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/send_otp_payload.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/register_entity.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_payload.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';
import 'package:suri_checking_event_app/features/auth/domain/repositories/auth_repositories.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<Failure, ProfileEntity>> postLogin(LoginPayload payload) async {
    return await authRepository.postLogin(payload);
  }

  Future<Either<Failure, RegisterEntity>> postRegister(
      RegisterPayload payload) async {
    return await authRepository.postRegister(payload);
  }

  Future<Either<Failure, bool>> postForgotPassword(String payload) async {
    return await authRepository.postForgotPassword(payload);
  }

  Future<Either<Failure, bool>> postSendOtp(SendOTPPayload payload) async {
    return await authRepository.postSendOtp(payload);
  }

  Future<Either<Failure, ProfileEntity>> postLoginGoogle(
      LoginGooglePayload payload) async {
    return await authRepository.postLoginGoogle(payload);
  }

  Future<Either<Failure, ProfileEntity>> postLoginApple(
      LoginApplePayload payload) async {
    return await authRepository.postLoginApple(payload);
  }

  Future<Either<Failure, bool>> getOtpRegister(String payload) async {
    return await authRepository.getOtpRegister(payload);
  }
}
