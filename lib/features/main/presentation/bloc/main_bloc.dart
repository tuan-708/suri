import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_state.dart';

import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  MainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) {});
    on<LoadProfile>(_onLoadProfile);
    on<UpdateAvatar>(_onUploadAvatar);
    on<LogOutProfile>(_onLogoutProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<MainState> emit) async {
    try {
      emit(state.copyWith(
        profile: null,
        isProfileLoading: true,
      ));

      final profile = await _sharedHelper.getProfile();

      profile!.photo = StringValid.url(profile.photo!);
      profile.name = profile.name ?? "";
      profile.phone = profile.phone ?? "";
      profile.username = profile.username ?? "";
      profile.email = profile.email ?? "";
      profile.addressDetail = profile.addressDetail ?? "";
      profile.rankName = profile.rankName ?? "";

      emit(state.copyWith(
          profile: profile, isProfileLoading: false, errorProfile: ''));
    } catch (e) {
      emit(MainInitial());
    }
  }

  FutureOr<void> _onUploadAvatar(
      UpdateAvatar event, Emitter<MainState> emit) async {
    emit(state.copyWith(
        profile:
            state.profile?.copyWith(photo: StringValid.url(event.urlAvatar)),
        isProfileLoading: false,
        errorProfile: ''));
  }

  FutureOr<void> _onLogoutProfile(
      LogOutProfile event, Emitter<MainState> emit) {
    emit(state.copyWith(
        profile: null, isProfileLoading: false, errorProfile: ''));
  }
}
