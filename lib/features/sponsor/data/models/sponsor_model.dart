import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_entity.dart';

class SponsorModel extends SponsorEntity {
  const SponsorModel({
    required int id,
    required int active,
    required String name,
    required String priceSponsor,
    required String photo,
    String? info,
    required String description,
    required DateTime createdTime,
    required List<dynamic> sponsorEvents,
  }) : super(
          id: id,
          active: active,
          name: name,
          priceSponsor: priceSponsor,
          photo: photo,
          info: info,
          description: description,
          createdTime: createdTime,
          sponsorEvents: sponsorEvents,
        );

  factory SponsorModel.fromJson(Map<String, dynamic> json) {
    return SponsorModel(
      id: json['id'] ?? 0,
      active: json['active'] ?? 0,
      name: json['name'] ?? '',
      priceSponsor: json['priceSponsor'] ?? '',
      photo: json['photo'] ?? '',
      info: json['info'],
      description: json['description'] ?? '',
      createdTime: DateTime.parse(json['createdTime'] ?? ''),
      sponsorEvents: json['sponsorEvents'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'name': name,
      'priceSponsor': priceSponsor,
      'photo': photo,
      'info': info,
      'description': description,
      'createdTime': createdTime.toIso8601String(),
      'sponsorEvents': sponsorEvents,
    };
  }
}
