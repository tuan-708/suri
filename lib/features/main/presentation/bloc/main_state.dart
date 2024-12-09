import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';

class MainState {
  Profile? profile;
  bool? isProfileLoading;
  String? errorProfile;

  MainState({
    this.profile,
    this.isProfileLoading = false,
    this.errorProfile,
  });

  MainState copyWith({
    Profile? profile,
    bool? isProfileLoading,
    String? errorProfile,
  }) {
    return MainState(
      profile: profile ?? this.profile,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      errorProfile: errorProfile ?? this.errorProfile,
    );
  }
}

class MainInitial extends MainState {}
