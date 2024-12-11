part of 'auth_bloc.dart';

class AuthState {}

class AuthInitial extends AuthState {}

// Login
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final ProfileEntity profile;
  LoginSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LoginLocked extends AuthState {
  final DateTime unlockTime;
  LoginLocked(this.unlockTime);

  @override
  List<Object?> get props => [unlockTime];
}

// Register
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final RegisterEntity profile;
  RegisterSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class RegisterFailure extends AuthState {
  final String error;
  RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Forget Password
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final bool isSended;
  ForgotPasswordSuccess(this.isSended);

  @override
  List<Object?> get props => [isSended];
}

class ForgotPasswordFailure extends AuthState {
  final String error;
  ForgotPasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Post Send otp
class PostSendOtpLoading extends AuthState {}

class PostSendOtpSuccess extends AuthState {
  final bool isSuccess;
  PostSendOtpSuccess(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class PostSendOtpFailure extends AuthState {
  final String error;
  PostSendOtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Login Google
class LoginGoogleLoading extends AuthState {}

class LoginGoogleSuccess extends AuthState {
  final ProfileEntity profile;
  LoginGoogleSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class LoginGoogleFailure extends AuthState {
  final String error;
  LoginGoogleFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Login Apple
class LoginAppleLoading extends AuthState {}

class LoginAppleSuccess extends AuthState {
  final ProfileEntity profile;
  LoginAppleSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

class LoginAppleFailure extends AuthState {
  final String error;
  LoginAppleFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class GetOtpRegisterLoading extends AuthState {}

class GetOtpRegisterSuccess extends AuthState {
  final bool isSuccess;
  GetOtpRegisterSuccess(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class GetOtpRegisterFailure extends AuthState {
  final String error;
  GetOtpRegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}
