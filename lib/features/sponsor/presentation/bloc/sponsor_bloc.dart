import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/usecase/sponsor_usecase.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_event.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_state.dart';

class SponsorBloc extends Bloc<SponsorEvent, SponsorState> {
  final SponsorUseCases sponsorUseCases;

  SponsorBloc({required this.sponsorUseCases}) : super(SponsorInitial()) {
    on<SponsorEvent>((event, emit) {});
    on<GetListSponsors>(_onLoadSponsors);

    on<GetSponsorDetail>(_onLoadSponsorDetail);

    on<GetListStoreCheckinEvent>(_onLoadListStoreCheckin);
  }

  FutureOr<void> _onLoadSponsors(
      GetListSponsors event, Emitter<SponsorState> emit) async {
    try {
      emit(GetSponsorsLoading());

      final res = await sponsorUseCases.getListSponsors(event.payload);

      res.fold(
        (l) => emit(GetSponsorsFailure(l.message)),
        (r) => emit(GetSponsorsSuccess(r)),
      );
    } catch (e) {
      emit(GetSponsorsFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoadSponsorDetail(
      GetSponsorDetail event, Emitter<SponsorState> emit) async {
    try {
      emit(GetSponsorDetailLoading());

      final res = await sponsorUseCases.getSponsorDetail(event.payload);

      res.fold((l) => emit(GetSponsorDetailFailure(l.message)), (r) {
        emit(GetSponsorDetailSuccess(r));
      });
    } catch (e) {
      emit(GetSponsorDetailFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoadListStoreCheckin(
      GetListStoreCheckinEvent event, Emitter<SponsorState> emit) async {
    try {
      emit(ListStoreCheckinLoading());

      final res = await sponsorUseCases.getListStoreCheckin(event.payload);

      res.fold((l) => emit(ListStoreCheckinFailure(l.message)), (r) {
        emit(ListStoreCheckinSuccess(r));
      });
    } catch (e) {
      emit(ListStoreCheckinFailure(e.toString()));
    }
  }
}
