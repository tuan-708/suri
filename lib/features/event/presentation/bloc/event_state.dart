import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_register_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/history_vote_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/remaining_votes_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_info_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_special_info_entity.dart';

class EventState {
  List<HistoryVoteEntity>? listHistoriesVote;
  List<EventEntity>? events;
  int? statusId = statusEvent['Sắp diễn ra'];
  String? errorEvents;
  List<KOLDetailEntity>? listKOLPaging;
  int? categoryId = 1001;

  EventState(
      {this.events,
      this.errorEvents = '',
      this.listHistoriesVote,
      this.listKOLPaging,
      this.statusId = 1001,
      this.categoryId = 1001});

  get list => null;

  EventState copyWith({
    List<EventEntity>? events,
    int? statusId,
    List<HistoryVoteEntity>? listHistoriesVote,
    String? errorEventDetail,
    List<KOLDetailEntity>? listKOLPaging,
    int? categoryId,
  }) {
    return EventState(
        events: events ?? this.events,
        statusId: statusId ?? this.statusId,
        listHistoriesVote: listHistoriesVote ?? this.listHistoriesVote,
        listKOLPaging: listKOLPaging ?? this.listKOLPaging,
        categoryId: categoryId ?? this.categoryId);
  }
}

class EventInitial extends EventState {}

// List Top3
class ListTop3KOLLoading extends EventState {}

class ListTop3KOLSuccess extends EventState {
  @override
  final List<ListKOLEntity> list;
  ListTop3KOLSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class ListTop3KOLFailure extends EventState {
  final String error;
  ListTop3KOLFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Histories Vote
class ListHistoriesVoteLoading extends EventState {}

class ListHistoriesVoteSuccess extends EventState {
  @override
  final List<HistoryVoteEntity> list;
  ListHistoriesVoteSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class ListHistoriesVoteFailure extends EventState {
  final String error;
  ListHistoriesVoteFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Remaining Votes
class RemainingVotesLoading extends EventState {}

class RemainingVotesSuccess extends EventState {
  final RemainingVotesEntity remainingVotes;
  RemainingVotesSuccess(this.remainingVotes);

  @override
  List<Object?> get props => [remainingVotes];
}

class RemainingVotesFailure extends EventState {
  final String error;
  RemainingVotesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Post Votes
class CreateVoteLoading extends EventState {}

class CreateVoteSuccess extends EventState {
  final bool status;
  CreateVoteSuccess(this.status);

  @override
  List<Object?> get props => [status];
}

class CreateVoteFailure extends EventState {
  final String error;
  CreateVoteFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Home Event
class HomeEventsLoading extends EventState {}

class HomeEventsSuccess extends EventState {
  @override
  final List<EventEntity>? list;
  HomeEventsSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class HomeEventsFailure extends EventState {
  final String error;
  HomeEventsFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// List Event Page
class EventsPagingLoading extends EventState {}

class EventsPagingSuccess extends EventState {
  @override
  final List<EventEntity>? list;

  EventsPagingSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class EventsPagingFailure extends EventState {
  final String error;
  EventsPagingFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Event Register
class EventRegisterLoading extends EventState {}

class EventRegisterSuccess extends EventState {
  final EventRegisterEntity? eventRegister;
  EventRegisterSuccess(this.eventRegister);

  @override
  List<Object?> get props => [eventRegister];
}

class EventRegisterFailure extends EventState {
  final String error;
  EventRegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Event Detail
class EventDetailLoading extends EventState {}

class EventDetailSuccess extends EventState {
  final EventDetailEntity? event;
  EventDetailSuccess(this.event);

  @override
  List<Object?> get props => [event];
}

class EventDetailFailure extends EventState {
  final String error;
  EventDetailFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Ticket Info
class TicketInfoLoading extends EventState {}

class TicketInfoSuccess extends EventState {
  final TicketInfoEntity ticketInfo;
  TicketInfoSuccess(this.ticketInfo);

  @override
  List<Object?> get props => [ticketInfo];
}

class TicketInfoFailure extends EventState {
  final String error;
  TicketInfoFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Post Scan Qr Event
class ScanQrCodeLoading extends EventState {}

class ScanQrCodeSuccess extends EventState {
  final String res;
  ScanQrCodeSuccess(this.res);

  @override
  List<Object?> get props => [res];
}

class ScanQrCodeFailure extends EventState {
  final String error;
  ScanQrCodeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// List KOL paging
class ListKOLPagingLoading extends EventState {}

class ListKOLPagingSuccess extends EventState {
  @override
  final List<KOLDetailEntity> list;
  ListKOLPagingSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class ListKOLPagingFailure extends EventState {
  final String error;
  ListKOLPagingFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// List KOL Searching
class ListKOLSearchingLoading extends EventState {}

class ListKOLSearchingSuccess extends EventState {
  @override
  final List<KOLDetailEntity> list;
  ListKOLSearchingSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class ListKOLSearchingFailure extends EventState {
  final String error;
  ListKOLSearchingFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Ticket Special Info
class TicketSpecialInfoLoading extends EventState {}

class TicketSpecialInfoSuccess extends EventState {
  final TicketSpecialInfoEntity ticketInfo;
  TicketSpecialInfoSuccess(this.ticketInfo);

  @override
  List<Object?> get props => [ticketInfo];
}

class TicketSpecialInfoFailure extends EventState {
  final String error;
  TicketSpecialInfoFailure(this.error);

  @override
  List<Object?> get props => [error];
}
