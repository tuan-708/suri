import 'dart:convert';

import 'package:suri_checking_event_app/features/event/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required int id,
    required int active,
    required bool isSpecialEvent,
    required String name,
    required String info,
    required String description,
    required String photo,
    required String bannerPhoto,
    required DateTime startDate,
    required DateTime endDate,
    required int eventStatusId,
    required int eventTypeId,
    required DateTime createdTime,
    required List<String> images,
    required dynamic eventStatus,
    required dynamic eventType,
    required List<dynamic> eventAccounts,
    required List<dynamic> eventGifts,
    required List<dynamic> sponsorEvents,
  }) : super(
          id: id,
          active: active,
          isSpecialEvent: isSpecialEvent,
          name: name,
          info: info,
          description: description,
          photo: photo,
          bannerPhoto: bannerPhoto,
          startDate: startDate,
          endDate: endDate,
          eventStatusId: eventStatusId,
          eventTypeId: eventTypeId,
          createdTime: createdTime,
          images: images,
          eventStatus: eventStatus,
          eventType: eventType,
          eventAccounts: eventAccounts,
          eventGifts: eventGifts,
          sponsorEvents: sponsorEvents,
        );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      active: json['active'] as int,
      isSpecialEvent: json['isSpecialEvent'],
      name: json['name'] ?? '',
      info: json['info'] ?? '',
      description: json['description'] ?? '',
      photo: json['photo'] ?? '',
      bannerPhoto: json['bannerPhoto'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      eventStatusId: json['eventStatusId'],
      eventTypeId: json['eventTypeId'],
      createdTime: DateTime.parse(json['createdTime']),
      images: json['images'].runtimeType != 'String'
          ? []
          : List<String>.from(jsonDecode(json['images'])),
      eventStatus: json['eventStatus'],
      eventType: json['eventType'],
      eventAccounts: List<dynamic>.from(json['eventAccounts'] as List),
      eventGifts: List<dynamic>.from(json['eventGifts'] as List),
      sponsorEvents: List<dynamic>.from(json['sponsorEvents'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'isSpecialEvent': isSpecialEvent,
      'name': name,
      'info': info,
      'description': description,
      'photo': photo,
      'bannerPhoto': bannerPhoto,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'eventStatusId': eventStatusId,
      'eventTypeId': eventTypeId,
      'createdTime': createdTime.toIso8601String(),
      'images': jsonEncode(images),
      'eventStatus': eventStatus,
      'eventType': eventType,
      'eventAccounts': eventAccounts,
      'eventGifts': eventGifts,
      'sponsorEvents': sponsorEvents,
    };
  }
}
