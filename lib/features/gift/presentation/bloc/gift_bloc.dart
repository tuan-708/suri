import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/gift/domain/usecase/gift_usecase.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_event.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  final GiftUseCases giftUseCases;

  GiftBloc({
    required this.giftUseCases,
  }) : super(EventInitial()) {
    on<GiftEvent>((event, emit) {});
    on<GetListGiftOfEvent>(_onLoadListGiftOfEvent);
    on<GetListGiftOfAccount>(_onLoadListGiftOfAccount);
  }

  Future<void> _onLoadListGiftOfEvent(
      GetListGiftOfEvent event, Emitter<GiftState> emit) async {
    try {
      emit(ListGiftOfEventLoading());

      final res = await giftUseCases.getListGiftOfEvent(event.payload);
      res.fold((l) {
        emit(ListGiftOfEventFailure(l.message));
      }, (r) {
        emit(ListGiftOfEventSuccess(r));
      });
    } catch (e) {
      emit(ListGiftOfEventFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoadListGiftOfAccount(
      GetListGiftOfAccount event, Emitter<GiftState> emit) async {
    try {
      emit(ListGiftOfAccountLoading());

      final res = await giftUseCases.getListGiftOfAccount();
      res.fold((l) {
        emit(ListGiftOfAccountFailure(l.message));
      }, (r) {
        emit(ListGiftOfAccountSuccess(r));
      });
    } catch (e) {
      emit(ListGiftOfAccountFailure(e.toString()));
    }
  }
}
