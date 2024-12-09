import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';

class UserState {}

class UserInitial extends UserState {}

// Delete Account
class PostDeleteAccountLoading extends UserState {}

class PostDeleteAccountSuccess extends UserState {
  final bool isSuccess;
  PostDeleteAccountSuccess(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class PostDeleteAccountFailure extends UserState {
  final String error;
  PostDeleteAccountFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Change password
class PostChangePasswordLoading extends UserState {}

class PostChangePasswordSuccess extends UserState {
  final ChangePasswordPayload response;
  PostChangePasswordSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class PostChangePasswordFailure extends UserState {
  final String error;
  PostChangePasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Change Avatar
class UploadAvatarLoading extends UserState {}

class UploadAvatarSuccess extends UserState {
  final String message;
  UploadAvatarSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UploadAvatarFailure extends UserState {
  final String error;
  UploadAvatarFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Change Profile
class ChangeProfileLoading extends UserState {}

class ChangeProfileSuccess extends UserState {
  final bool isSuccess;
  ChangeProfileSuccess(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class ChangeProfileFailure extends UserState {
  final String error;
  ChangeProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Get Event Remains
class GetEventRemainsLoading extends UserState {}

class GetEventRemainsSuccess extends UserState {
  final int amount;
  GetEventRemainsSuccess(this.amount);

  @override
  List<Object?> get props => [amount];
}

class GetEventRemainsFailure extends UserState {
  final String error;
  GetEventRemainsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
