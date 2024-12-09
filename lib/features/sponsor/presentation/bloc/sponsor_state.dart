import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_detail_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/store_checkin_entity.dart';

class SponsorState {}

class SponsorInitial extends SponsorState {}

// Sponsor
class GetSponsorsLoading extends SponsorState {}

class GetSponsorsSuccess extends SponsorState {
  final List<SponsorEntity>? sponsors;
  GetSponsorsSuccess(this.sponsors);

  @override
  List<Object?> get props => [sponsors];
}

class GetSponsorsFailure extends SponsorState {
  final String error;
  GetSponsorsFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Sponsor Detail
class GetSponsorDetailLoading extends SponsorState {}

class GetSponsorDetailSuccess extends SponsorState {
  final SponsorDetailEntity sponsorDetail;
  GetSponsorDetailSuccess(this.sponsorDetail);

  @override
  List<Object?> get props => [sponsorDetail];
}

class GetSponsorDetailFailure extends SponsorState {
  final String error;
  GetSponsorDetailFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// List Store Checkin
class ListStoreCheckinLoading extends SponsorState {}

class ListStoreCheckinSuccess extends SponsorState {
  @override
  final List<StoreCheckinEntity> list;
  ListStoreCheckinSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class ListStoreCheckinFailure extends SponsorState {
  final String error;
  ListStoreCheckinFailure(this.error);

  @override
  List<Object?> get props => [error];
}
