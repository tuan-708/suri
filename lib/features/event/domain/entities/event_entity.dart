import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final int id;
  final int active;
  final bool isSpecialEvent;
  final String name;
  final String info;
  final String description;
  final String photo;
  final String bannerPhoto;
  final DateTime startDate;
  final DateTime endDate;
  final int eventStatusId;
  final int eventTypeId;
  final DateTime createdTime;
  final List<String> images;
  final dynamic eventStatus;
  final dynamic eventType;
  final List<dynamic> eventAccounts;
  final List<dynamic> eventGifts;
  final List<dynamic> sponsorEvents;

  const EventEntity({
    required this.id,
    required this.isSpecialEvent,
    required this.active,
    required this.name,
    required this.info,
    required this.description,
    required this.photo,
    required this.bannerPhoto,
    required this.startDate,
    required this.endDate,
    required this.eventStatusId,
    required this.eventTypeId,
    required this.createdTime,
    required this.images,
    required this.eventStatus,
    required this.eventType,
    required this.eventAccounts,
    required this.eventGifts,
    required this.sponsorEvents,
  });

  @override
  List<Object?> get props => [
        id,
        active,
        isSpecialEvent,
        name,
        info,
        description,
        photo,
        bannerPhoto,
        startDate,
        endDate,
        eventStatusId,
        eventTypeId,
        createdTime,
        images,
        eventStatus,
        eventType,
        eventAccounts,
        eventGifts,
        sponsorEvents,
      ];
}
