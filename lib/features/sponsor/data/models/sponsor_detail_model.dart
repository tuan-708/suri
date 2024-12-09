import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_detail_entity.dart';

class SponsorDetailModel extends SponsorDetailEntity {
  const SponsorDetailModel({
    required int id,
    required int active,
    required String name,
    required String priceSponsor,
    required String photo,
    String? info,
    required String description,
    required String createdTime,
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

  // JSON parsing methods
  factory SponsorDetailModel.fromJson(Map<String, dynamic> json) {
    return SponsorDetailModel(
      id: json['id'],
      active: json['active'],
      name: json['name'] ?? '',
      priceSponsor: json['priceSponsor'] ?? '',
      photo: json['photo'] ?? '',
      info: json['info'] ?? '',
      description: json['description'] ?? '',
      createdTime: json['createdTime'],
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
      'createdTime': createdTime,
      'sponsorEvents': sponsorEvents,
    };
  }
}
