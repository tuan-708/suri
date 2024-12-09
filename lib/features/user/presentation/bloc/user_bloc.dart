import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/user/domain/usecase/user_usecase.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_event.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases userUseCases;

  UserBloc({required this.userUseCases}) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<PostDeleteAccount>(_onPostDeleteAccount);
    on<PostChangePassword>(_onPostChangePassword);
    on<UploadAvatar>(_onPostUploadAvatar);
    on<ChangeProfile>(_onPostChangeProfile);
    on<GetEventRemains>(_onGetEventRemains);
  }

  FutureOr<void> _onPostDeleteAccount(
      PostDeleteAccount event, Emitter<UserState> emit) async {
    try {
      emit(PostDeleteAccountLoading());

      final res = await userUseCases.postDeleteAccount();

      res.fold(
        (l) => emit(PostDeleteAccountFailure(l.message)),
        (r) => emit(PostDeleteAccountSuccess(r)),
      );
    } catch (e) {
      emit(PostDeleteAccountFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostChangePassword(
      PostChangePassword event, Emitter<UserState> emit) async {
    try {
      emit(PostChangePasswordLoading());

      final res = await userUseCases.postChangePassword(event.payload);

      res.fold(
        (l) => emit(PostChangePasswordFailure(l.message)),
        (r) => emit(PostChangePasswordSuccess(r)),
      );
    } catch (e) {
      emit(PostChangePasswordFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostUploadAvatar(
      UploadAvatar event, Emitter<UserState> emit) async {
    try {
      emit(UploadAvatarLoading());

      final res = await userUseCases.postSingleFile(event.pickFile);

      res.fold(
        (l) => emit(UploadAvatarFailure(l.message)),
        (r) => emit(UploadAvatarSuccess(r)),
      );
    } catch (e) {
      emit(UploadAvatarFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostChangeProfile(
      ChangeProfile event, Emitter<UserState> emit) async {
    try {
      emit(ChangeProfileLoading());

      final res = await userUseCases.postChangeProfile(event.payload);

      res.fold(
        (l) => emit(ChangeProfileFailure(l.message)),
        (r) => emit(ChangeProfileSuccess(r)),
      );
    } catch (e) {
      emit(ChangeProfileFailure(e.toString()));
    }
  }

  FutureOr<void> _onGetEventRemains(
      GetEventRemains event, Emitter<UserState> emit) async {
    try {
      emit(GetEventRemainsLoading());

      final res = await userUseCases.getVoteRemains(event.payload);

      res.fold(
        (l) => emit(GetEventRemainsFailure(l.message)),
        (r) => emit(GetEventRemainsSuccess(r)),
      );
    } catch (e) {
      emit(GetEventRemainsFailure(e.toString()));
    }
  }
}
