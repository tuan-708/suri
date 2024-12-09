import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_apple_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_google_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/login_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/register_payload.dart';
import 'package:suri_checking_event_app/features/auth/data/models/send_otp_payload.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/register_entity.dart';
import 'package:suri_checking_event_app/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases authUseCases;

  AuthBloc({required this.authUseCases}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<PostLogin>(_onPostLogin);
    on<PostRegister>(_onPostRegister);
    on<PostForgotPassword>(_onPostForgotPassword);
    on<PostSendOtp>(_onPostSendOtp);
    on<PostLoginGoogle>(_onPostLoginGoogle);
    on<PostLoginApple>(_onPostLoginApple);
    on<GetOtpRegister>(_onGetOtpRegister);
  }

  FutureOr<void> _onPostLogin(event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoading());
      final res = await authUseCases.postLogin(event.payload);

      res.fold(
        (l) => emit(LoginFailure(l.message)),
        (r) {
          emit(LoginSuccess(r));
        },
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostRegister(
      PostRegister event, Emitter<AuthState> emit) async {
    try {
      emit(RegisterLoading());
      final res = await authUseCases.postRegister(event.payload);

      res.fold(
        (l) => emit(RegisterFailure(l.message)),
        (r) => emit(RegisterSuccess(r)),
      );
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostForgotPassword(
      PostForgotPassword event, Emitter<AuthState> emit) async {
    try {
      emit(ForgotPasswordLoading());
      final res = await authUseCases.postForgotPassword(event.payload);

      res.fold(
        (l) => emit(ForgotPasswordFailure(l.message)),
        (r) => emit(ForgotPasswordSuccess(r)),
      );
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostSendOtp(
      PostSendOtp event, Emitter<AuthState> emit) async {
    try {
      emit(PostSendOtpLoading());
      final res = await authUseCases.postSendOtp(event.payload);

      res.fold(
        (l) => emit(PostSendOtpFailure(l.message)),
        (r) => emit(PostSendOtpSuccess(r)),
      );
    } catch (e) {
      emit(PostSendOtpFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostLoginGoogle(
      PostLoginGoogle event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoading());
      final res = await authUseCases.postLoginGoogle(event.payload);

      res.fold(
        (l) => emit(LoginFailure(l.message)),
        (r) {
          emit(LoginSuccess(r));
        },
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostLoginApple(
      PostLoginApple event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoading());
      final res = await authUseCases.postLoginApple(event.payload);

      res.fold(
        (l) => emit(LoginFailure(l.message)),
        (r) {
          emit(LoginSuccess(r));
        },
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _onGetOtpRegister(
      GetOtpRegister event, Emitter<AuthState> emit) async {
    try {
      emit(GetOtpRegisterLoading());
      final res = await authUseCases.getOtpRegister(event.payload);

      res.fold(
        (l) => emit(GetOtpRegisterFailure(l.message)),
        (r) => emit(GetOtpRegisterSuccess(r)),
      );
    } catch (e) {
      emit(GetOtpRegisterFailure(e.toString()));
    }
  }
}
