import 'package:suri_checking_event_app/features/sponsor/data/models/list_sponsor_payload.dart';

class SponsorEvent {}

class GetListSponsors extends SponsorEvent {
  final ListSponsorsPayload payload;
  GetListSponsors(this.payload);

  @override
  List<Object?> get props => [payload];
}

class GetSponsorDetail extends SponsorEvent {
  final int payload;
  GetSponsorDetail(this.payload);

  @override
  List<Object?> get props => [payload];
}

// List Store Checkin
class GetListStoreCheckinEvent extends SponsorEvent {
  int payload;
  GetListStoreCheckinEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}
