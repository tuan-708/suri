import 'package:suri_checking_event_app/features/gift/domain/entities/event_gift_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_account_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_entity.dart';

class GiftState {}

class EventInitial extends GiftState {}

// List Gift
class ListGiftOfEventLoading extends GiftState {}

class ListGiftOfEventSuccess extends GiftState {
  final List<GiftEntity> list;
  ListGiftOfEventSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class ListGiftOfEventFailure extends GiftState {
  final String error;
  ListGiftOfEventFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// List Gift Accoount
class ListGiftOfAccountLoading extends GiftState {}

class ListGiftOfAccountSuccess extends GiftState {
  final List<GiftAccountEntity> gifts;
  ListGiftOfAccountSuccess(this.gifts);

  @override
  List<Object?> get props => [gifts];
}

class ListGiftOfAccountFailure extends GiftState {
  final String error;
  ListGiftOfAccountFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// List Gift
class GetListGiftEventLoading extends GiftState {}

class GetListGiftEventSuccess extends GiftState {
  final List<EventGiftEntity> list;
  GetListGiftEventSuccess(this.list);

  @override
  List<Object?> get props => [list];
}

class GetListGiftEventFailure extends GiftState {
  final String error;
  GetListGiftEventFailure(this.error);

  @override
  List<Object?> get props => [error];
}
