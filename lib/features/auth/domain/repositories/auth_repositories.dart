import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_apple_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_google_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/send_otp_payload.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/register_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ProfileEntity>> postLogin(LoginPayload payload);
  Future<Either<Failure, RegisterEntity>> postRegister(RegisterPayload payload);
  Future<Either<Failure, bool>> postForgotPassword(String payload);
  Future<Either<Failure, bool>> postSendOtp(SendOTPPayload payload);
  Future<Either<Failure, ProfileEntity>> postLoginGoogle(
      LoginGooglePayload payload);
  Future<Either<Failure, ProfileEntity>> postLoginApple(
      LoginApplePayload payload);
  Future<Either<Failure, bool>> getOtpRegister(String payload);
}
