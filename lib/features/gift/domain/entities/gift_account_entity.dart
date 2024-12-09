import 'package:equatable/equatable.dart';

class GiftAccountEntity extends Equatable {
  final String? eventGiftName;
  final String? accountName;
  final String? accountGiftStatusName;
  final String? giftName;
  final String? eventName;
  final String? eventPhoto;
  final String? eventInfo;
  final String? eventBanner;
  final DateTime? eventStartDate;
  final DateTime? eventEndDate;
  final String? photo;
  final double? price;
  final bool isSender;
  final int id;
  final int active;
  final String? name;
  final String? info;
  final String? description;
  final int eventGiftId;
  final int accountId;
  final int accountGiftStatusId;
  final DateTime? createdTime;
  final String? account;
  final String? accountGiftStatus;
  final String? eventGift;

  const GiftAccountEntity({
    this.eventGiftName,
    this.accountName,
    this.accountGiftStatusName,
    this.giftName,
    this.eventName,
    this.eventPhoto,
    this.eventInfo,
    this.eventBanner,
    this.eventStartDate,
    this.eventEndDate,
    this.photo,
    this.price,
    required this.isSender,
    required this.id,
    required this.active,
    this.name,
    this.info,
    this.description,
    required this.eventGiftId,
    required this.accountId,
    required this.accountGiftStatusId,
    this.createdTime,
    this.account,
    this.accountGiftStatus,
    this.eventGift,
  });

  @override
  List<Object?> get props => [
        eventGiftName,
        accountName,
        accountGiftStatusName,
        giftName,
        eventName,
        eventPhoto,
        eventInfo,
        eventBanner,
        eventStartDate,
        eventEndDate,
        photo,
        price,
        isSender,
        id,
        active,
        name,
        info,
        description,
        eventGiftId,
        accountId,
        accountGiftStatusId,
        createdTime,
        account,
        accountGiftStatus,
        eventGift,
      ];
}
