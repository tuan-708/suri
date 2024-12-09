part of 'auth_bloc.dart';

class AuthEvent {}

// Login
class PostLogin extends AuthEvent {
  final LoginPayload payload;
  PostLogin(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Đăng ký
class PostRegister extends AuthEvent {
  final RegisterPayload payload;
  PostRegister(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Quên mật khẩu
class PostForgotPassword extends AuthEvent {
  final String payload;
  PostForgotPassword(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Send Otp
class PostSendOtp extends AuthEvent {
  final SendOTPPayload payload;
  PostSendOtp(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Login Google
class PostLoginGoogle extends AuthEvent {
  final LoginGooglePayload payload;
  PostLoginGoogle(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Login Apple
class PostLoginApple extends AuthEvent {
  final LoginApplePayload payload;
  PostLoginApple(this.payload);

  @override
  List<Object?> get props => [payload];
}

class GetOtpRegister extends AuthEvent {
  final String payload;
  GetOtpRegister(this.payload);

  @override
  List<Object?> get props => [payload];
}
