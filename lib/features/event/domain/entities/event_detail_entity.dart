import 'package:equatable/equatable.dart';

class EventDetailEntity extends Equatable {
  final String eventStatusName;
  final String eventTypeName;
  final bool isSender;
  final bool isSpecialEvent;
  final List<String> imageString;
  final List<String> images;
  final List<String> imageList;
  final int id;
  final int active;
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
  final dynamic eventStatus;
  final dynamic eventType;
  final List<dynamic> eventAccounts;
  final List<dynamic> eventGifts;
  final List<dynamic> sponsorEvents;

  const EventDetailEntity({
    required this.eventStatusName,
    required this.eventTypeName,
    required this.isSender,
    required this.isSpecialEvent,
    required this.imageString,
    required this.images,
    required this.imageList,
    required this.id,
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
    this.eventStatus,
    this.eventType,
    required this.eventAccounts,
    required this.eventGifts,
    required this.sponsorEvents,
  });

  @override
  List<Object?> get props => [
        eventStatusName,
        eventTypeName,
        isSender,
        imageString,
        images,
        id,
        active,
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
        eventStatus,
        eventType,
        eventAccounts,
        eventGifts,
        sponsorEvents,
      ];
}
