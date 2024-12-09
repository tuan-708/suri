class GiftEvent {}

// Danh sách gift paging
class GetListGiftOfEvent extends GiftEvent {
  final int payload;
  GetListGiftOfEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Danh sách Gift Account
class GetListGiftOfAccount extends GiftEvent {
  GetListGiftOfAccount();

  @override
  List<Object?> get props => [];
}

// Danh sách Quà của sự kiện đặc biệt
class GetListGiftEvent extends GiftEvent {
  final int payload;
  GetListGiftEvent(this.payload);

  @override
  List<Object?> get props => [];
}
