import 'package:suri_checking_event_app/features/event/data/models/event_register_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_event_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_paging_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/scan_qr_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/searching_kol_payload.dart';

class EventEvent {}

// Danh sách event paging
class GetListEventPaging extends EventEvent {
  final ListEventsPayload payload;
  GetListEventPaging(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Refresh
class GetListEventRefresh extends EventEvent {
  final ListEventsPayload payload;
  GetListEventRefresh(this.payload);

  @override
  List<Object?> get props => [payload];
}

// EventDetail
class GetEventDetail extends EventEvent {
  final int payload;
  GetEventDetail(this.payload);

  @override
  List<Object?> get props => [payload];
}

// GetListTop3 KOL
class GetListTop3KOL extends EventEvent {
  GetListTop3KOL();

  @override
  List<Object?> get props => [];
}

// GetListHistory vote
class GetListHistoriesVote extends EventEvent {
  HistoryVotePayload payload;
  GetListHistoriesVote(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Get remaining votes
class GetRemainingVotes extends EventEvent {
  GetRemainingVotes();

  @override
  List<Object?> get props => [];
}

// Vote
class PostVote extends EventEvent {
  int payload;
  PostVote(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Home Event
class GetHomeEvent extends EventEvent {
  ListEventsPayload payload;
  GetHomeEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

//  Event Register
class PostEventRegisterEvent extends EventEvent {
  EventRegisterPayload payload;
  PostEventRegisterEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Ticket Info
class GetTicketInfoEvent extends EventEvent {
  int payload;
  GetTicketInfoEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Ticket Special Info
class GetTicketSpecialInfoEvent extends EventEvent {
  int payload;
  GetTicketSpecialInfoEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Scan Qr
class PostEventScanQrEvent extends EventEvent {
  ScanQrPayload payload;
  PostEventScanQrEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

// List Kol pagin
class GetListKOLPagingEvent extends EventEvent {
  ListKOLPagingPayload payload;
  GetListKOLPagingEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

// List Kol Searching
class GetListKOLSearchingEvent extends EventEvent {
  SearchingKOLPayload payload;
  GetListKOLSearchingEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}
