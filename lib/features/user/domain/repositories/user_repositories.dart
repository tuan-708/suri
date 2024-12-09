import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_profile_payload.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> postDeleteAccount();
  Future<Either<Failure, ChangePasswordPayload>> postChangePassword(
      ChangePasswordPayload payload);
  Future<Either<Failure, dynamic>> postSingleFile(XFile pickFile);
  Future<Either<Failure, bool>> postChangeProfile(ChangeProfilePayload payload);
  Future<Either<Failure, int>> getVoteRemains(int payload);
}
