import 'package:equatable/equatable.dart';

class GiftEntity extends Equatable {
  final String giftName;
  final String eventName;
  final String eventPhoto;
  final String eventInfo;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String photo;
  final double price;
  final bool isSender;
  final int id;
  final int active;
  final int? quantity;
  final String name;
  final String? info;
  final String? description;
  final DateTime createdTime;
  final int giftId;
  final int eventId;
  final dynamic event;
  final dynamic gift;
  final List<dynamic> accountGifts;

  const GiftEntity({
    required this.giftName,
    required this.eventName,
    required this.eventPhoto,
    required this.eventInfo,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.photo,
    required this.price,
    required this.isSender,
    required this.id,
    required this.active,
    this.quantity,
    required this.name,
    this.info,
    this.description,
    required this.createdTime,
    required this.giftId,
    required this.eventId,
    this.event,
    this.gift,
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
        id,
        active,
        quantity,
        name,
        info,
        description,
        createdTime,
        giftId,
        eventId,
        event,
        gift,
        accountGifts,
      ];
}
