import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_profile_payload.dart';
import 'package:suri_checking_event_app/features/user/domain/repositories/user_repositories.dart';

class UserUseCases {
  final UserRepository userRepository;
  UserUseCases({required this.userRepository});

  Future<Either<Failure, bool>> postDeleteAccount() async {
    return await userRepository.postDeleteAccount();
  }

  Future<Either<Failure, ChangePasswordPayload>> postChangePassword(
      ChangePasswordPayload payload) async {
    return await userRepository.postChangePassword(payload);
  }

  Future<Either<Failure, dynamic>> postSingleFile(XFile pickFile) async {
    return await userRepository.postSingleFile(pickFile);
  }

  Future<Either<Failure, bool>> postChangeProfile(
      ChangeProfilePayload payload) async {
    return await userRepository.postChangeProfile(payload);
  }

  Future<Either<Failure, int>> getVoteRemains(int payload) async {
    return await userRepository.getVoteRemains(payload);
  }
}
