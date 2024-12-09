import 'package:equatable/equatable.dart';

abstract class SponsorEntity extends Equatable {
  final int id;
  final int active;
  final String name;
  final String priceSponsor;
  final String photo;
  final String? info;
  final String description;
  final DateTime createdTime;
  final List<dynamic> sponsorEvents;

  const SponsorEntity({
    required this.id,
    required this.active,
    required this.name,
    required this.priceSponsor,
    required this.photo,
    this.info,
    required this.description,
    required this.createdTime,
    required this.sponsorEvents,
  });

  @override
  List<Object?> get props => [
        id,
        active,
        name,
        priceSponsor,
        photo,
        info,
        description,
        createdTime,
        sponsorEvents,
      ];
}
