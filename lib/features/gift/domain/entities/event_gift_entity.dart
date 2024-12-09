import 'package:equatable/equatable.dart';

class EventGiftEntity extends Equatable {
  final String giftName;
  final String eventName;
  final String eventPhoto;
  final String eventInfo;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String photo;
  final double price;
  final bool isSender;
  final String eventGiftTypeName;
  final int id;
  final int active;
  final int? quantity;
  final String name;
  final String? info;
  final String? description;
  final DateTime createdTime;
  final int giftId;
  final int eventId;
  final int eventGiftTypeId;
  final dynamic event;
  final dynamic gift;
  final dynamic eventGiftType;
  final List<dynamic> accountGifts;

  const EventGiftEntity({
    required this.giftName,
    required this.eventName,
    required this.eventPhoto,
    required this.eventInfo,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.photo,
    required this.price,
    required this.isSender,
    required this.eventGiftTypeName,
    required this.id,
    required this.active,
    this.quantity,
    required this.name,
    this.info,
    this.description,
    required this.createdTime,
    required this.giftId,
    required this.eventId,
    required this.eventGiftTypeId,
    this.event,
    this.gift,
    this.eventGiftType,
    required this.accountGifts,
  });

  @override
  List<Object?> get props => [
        giftName,
        eventName,
        eventPhoto,
        eventInfo,
        eventStartDate,
        eventEndDate,
        photo,
        price,
        isSender,
        eventGiftTypeName,
        id,
        active,
        quantity,
        name,
        info,
        description,
        createdTime,
        giftId,
        eventId,
        eventGiftTypeId,
        event,
        gift,
        eventGiftType,
        accountGifts,
      ];
}
