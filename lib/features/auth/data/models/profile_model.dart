import 'package:equatable/equatable.dart';

import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity with EquatableMixin {
  const ProfileModel({
    String? accessToken,
    Profile? profile,
  }) : super(
          accessToken: accessToken,
          profile: profile,
        );

  @override
  List<Object?> get props => [accessToken, profile];

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      accessToken: json['accessToken'] as String?,
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'profile': profile?.toJson(),
    };
  }
}
