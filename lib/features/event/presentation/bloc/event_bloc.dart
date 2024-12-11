import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/history_vote_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/usecase/event_usecase.dart';
import 'package:suri_checking_event_app/features/event/domain/usecase/kol_usecase.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';

import 'package:suri_checking_event_app/features/home/domain/usecase/home_usecase.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final HomeUseCases homeUseCases;
  final EventUseCases eventUseCases;
  final KOLUseCases kolUseCases;

  EventBloc(
      {required this.homeUseCases,
      required this.eventUseCases,
      required this.kolUseCases})
      : super(EventInitial()) {
    on<EventEvent>((event, emit) {});
    on<GetListEventPaging>(_onLoadEvents);
    on<GetListEventRefresh>(_onRefreshEvents);
    on<GetEventDetail>(_onEventDetail);
    on<GetListTop3KOL>(_onLoadTop3KOL);
    on<GetListHistoriesVote>(_onLoadHistoriesVote);
    on<GetRemainingVotes>(_onLoadRemainingVotes);
    on<PostVote>(_onPostVote);
    on<GetHomeEvent>(_onLoadHomeEvents);
    on<PostEventRegisterEvent>(_onPostEventRegister);
    on<GetTicketInfoEvent>(_onLoadTicketInfo);
    on<PostEventScanQrEvent>(_onPostScanQrCode);
    on<GetListKOLPagingEvent>(_onLoadKOLPaging);
    on<GetListKOLSearchingEvent>(_onLoadKOLSearching);
    on<GetTicketSpecialInfoEvent>(_onLoadTicketSpecialInfo);
  }

  Future<void> _onLoadEvents(
      GetListEventPaging event, Emitter<EventState> emit) async {
    try {
      if (event.payload.pageIndex == 1) {
        emit(EventsPagingLoading());
      }

      late List<EventEntity> updatedEvents =
          List<EventEntity>.of(state.events ?? []);

      final res = await eventUseCases.getListEvents(event.payload);

      if (state.statusId != event.payload.statusId) {
        res.fold((l) {
          if (state.events!.isNotEmpty) {
            emit(EventsPagingSuccess(updatedEvents));
          } else {
            emit(EventsPagingFailure(l.message));
          }
        }, (r) {
          updatedEvents = List<EventEntity>.of(r);
          emit(EventsPagingSuccess(r));
        });
      } else {
        res.fold((l) {
          if (state.events!.isNotEmpty) {
            emit(EventsPagingSuccess(updatedEvents));
          } else {
            emit(EventsPagingFailure(l.message));
          }
        }, (r) {
          updatedEvents = List<EventEntity>.of(updatedEvents)..addAll(r);

          emit(EventsPagingSuccess(updatedEvents));
        });
      }

      emit(state.copyWith(events: updatedEvents));
      emit(state.copyWith(statusId: event.payload.statusId));
    } catch (e) {
      emit(EventsPagingFailure(e.toString()));
    }
  }

  Future<void> _onRefreshEvents(
      GetListEventRefresh event, Emitter<EventState> emit) async {
    try {
      emit(EventsPagingLoading());

      late List<EventEntity> updatedEvents =
          List<EventEntity>.of(state.events ?? []);

      final res = await eventUseCases.getListEvents(event.payload);

      res.fold((l) {
        if (state.events!.isNotEmpty) {
          emit(EventsPagingSuccess(updatedEvents));
        } else {
          emit(EventsPagingFailure(l.message));
        }
      }, (r) {
        updatedEvents = List<EventEntity>.of(r);
        emit(EventsPagingSuccess(r));
      });

      emit(state.copyWith(events: updatedEvents));
      emit(state.copyWith(statusId: event.payload.statusId));
    } catch (e) {
      emit(EventsPagingFailure(e.toString()));
    }
  }

  Future<void> _onEventDetail(
      GetEventDetail event, Emitter<EventState> emit) async {
    try {
      emit(EventDetailLoading());

      final res = await eventUseCases.getEventDetail(event.payload);

      res.fold((l) => emit(EventDetailFailure(l.message)), (r) {
        emit(EventDetailSuccess(r));
      });
    } catch (e) {
      emit(EventDetailFailure(e.toString()));
    }
  }

  Future<void> _onLoadTop3KOL(
      GetListTop3KOL event, Emitter<EventState> emit) async {
    try {
      emit(ListTop3KOLLoading());

      final res = await kolUseCases.getListTop3KOL();

      res.fold((l) => emit(ListTop3KOLFailure(l.message)),
          (r) => emit(ListTop3KOLSuccess(r)));
    } catch (e) {
      ListTop3KOLFailure(e.toString());
    }
  }

  Future<void> _onLoadHistoriesVote(
      GetListHistoriesVote event, Emitter<EventState> emit) async {
    try {
      if (event.payload.pageIndex == 1) {
        emit(ListHistoriesVoteLoading());
        emit(state.copyWith(listHistoriesVote: []));
      }

      late List<HistoryVoteEntity> updatedHistories =
          List<HistoryVoteEntity>.of(state.listHistoriesVote ?? []);

      final res = await kolUseCases.getListHistoryVote(event.payload);

      res.fold((l) {
        if (state.listHistoriesVote!.isNotEmpty) {
          emit(ListHistoriesVoteSuccess(updatedHistories));
        } else {
          emit(ListHistoriesVoteFailure(l.message));
        }
      }, (r) {
        updatedHistories =
            List<HistoryVoteEntity>.of(state.listHistoriesVote ?? [])
              ..addAll(r);
        emit(ListHistoriesVoteSuccess(updatedHistories));
      });
      emit(state.copyWith(listHistoriesVote: updatedHistories));
    } catch (e) {
      emit(ListHistoriesVoteFailure(e.toString()));
    }
  }

  Future<void> _onLoadRemainingVotes(
      GetRemainingVotes event, Emitter<EventState> emit) async {
    try {
      emit(RemainingVotesLoading());

      final res = await kolUseCases.getRemainingVotes();

      res.fold((l) {
        emit(RemainingVotesFailure(l.message));
      }, (r) {
        emit(RemainingVotesSuccess(r));
      });
    } catch (e) {
      emit(RemainingVotesFailure(e.toString()));
    }
  }

  Future<void> _onPostVote(PostVote event, Emitter<EventState> emit) async {
    try {
      emit(CreateVoteLoading());

      final res = await kolUseCases.postVoteKol(event.payload);

      res.fold((l) {
        emit(CreateVoteFailure(l.message));
      }, (r) {
        emit(CreateVoteSuccess(r));
      });
    } catch (e) {
      emit(CreateVoteFailure(e.toString()));
    }
  }

  Future<void> _onLoadHomeEvents(
      GetHomeEvent event, Emitter<EventState> emit) async {
    try {
      emit(HomeEventsLoading());

      final res = await eventUseCases.getListEvents(event.payload);

      res.fold((l) => emit(HomeEventsFailure(l.message)), (r) {
        emit(HomeEventsSuccess(r));
      });
    } catch (e) {
      emit(HomeEventsFailure(e.toString()));
    }
  }

  Future<void> _onPostEventRegister(
      PostEventRegisterEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventRegisterLoading());

      final res = await eventUseCases.postEventRegister(event.payload);

      res.fold((l) => emit(EventRegisterFailure(l.message)), (r) {
        emit(EventRegisterSuccess(r));
      });
    } catch (e) {
      emit(EventRegisterFailure(e.toString()));
    }
  }

  Future<void> _onLoadTicketInfo(
      GetTicketInfoEvent event, Emitter<EventState> emit) async {
    try {
      emit(TicketInfoLoading());

      final res = await eventUseCases.getTicketInfo(event.payload);

      res.fold((l) => emit(TicketInfoFailure(l.message)), (r) {
        emit(TicketInfoSuccess(r));
      });
    } catch (e) {
      emit(TicketInfoFailure(e.toString()));
    }
  }

  FutureOr<void> _onPostScanQrCode(
      PostEventScanQrEvent event, Emitter<EventState> emit) async {
    try {
      emit(ScanQrCodeLoading());

      final res = await eventUseCases.postScanQrCode(event.payload);

      res.fold((l) => emit(ScanQrCodeFailure(l.message)), (r) {
        emit(ScanQrCodeSuccess(r as String));
      });
    } catch (e) {
      emit(ScanQrCodeFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoadKOLPaging(
      GetListKOLPagingEvent event, Emitter<EventState> emit) async {
    try {
      if (event.payload.pageIndex == 1) {
        emit(ListKOLPagingLoading());
      }

      late List<KOLDetailEntity> updatedKols =
          List<KOLDetailEntity>.of((state.listKOLPaging ?? []));

      final res = await kolUseCases.getListKOLPaging(event.payload);

      if (state.categoryId != event.payload.categoryId) {
        res.fold((l) {
          if (state.listKOLPaging!.isNotEmpty) {
            emit(ListKOLPagingSuccess(updatedKols));
          } else {
            emit(ListKOLPagingFailure(l.message));
          }
        }, (r) {
          updatedKols = List<KOLDetailEntity>.of(r);
          emit(ListKOLPagingSuccess(r));
        });
      } else {
        res.fold((l) {
          if (state.listKOLPaging!.isNotEmpty) {
            emit(ListKOLPagingSuccess(List<KOLDetailEntity>.of(updatedKols)));
          } else {
            emit(ListKOLPagingFailure(l.message));
          }
        }, (r) {
          updatedKols = List<KOLDetailEntity>.of(updatedKols)..addAll(r);
          emit(ListKOLPagingSuccess(updatedKols));
        });
      }

      emit(state.copyWith(listKOLPaging: updatedKols));
      emit(state.copyWith(categoryId: event.payload.categoryId));
    } catch (e) {
      emit(ListKOLPagingFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoadKOLSearching(
      GetListKOLSearchingEvent event, Emitter<EventState> emit) async {
    try {
      emit(ListKOLSearchingLoading());

      final res = await kolUseCases.getLitKOLSearching(event.payload);

      res.fold((l) {
        emit(ListKOLSearchingFailure(l.message));
      }, (r) {
        emit(ListKOLSearchingSuccess(r));
      });
    } catch (e) {
      emit(ListKOLSearchingFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoadTicketSpecialInfo(
      GetTicketSpecialInfoEvent event, Emitter<EventState> emit) async {
    try {
      emit(TicketSpecialInfoLoading());

      final res = await eventUseCases.getTicketSpecialInfo(event.payload);

      res.fold((l) => emit(TicketSpecialInfoFailure(l.message)), (r) {
        emit(TicketSpecialInfoSuccess(r));
      });
    } catch (e) {
      emit(TicketSpecialInfoFailure(e.toString()));
    }
  }
}
