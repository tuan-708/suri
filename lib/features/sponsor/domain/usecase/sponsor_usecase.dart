import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_sponsor_payload.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_detail_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/store_checkin_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/repositories/sponsor_repositories.dart';

class SponsorUseCases {
  final SponsorRepository sponsorRepository;
  SponsorUseCases({required this.sponsorRepository});

  Future<Either<Failure, List<SponsorEntity>>> getListSponsors(
      ListSponsorsPayload payload) async {
    return await sponsorRepository.getListSponsors(payload);
  }

  Future<Either<Failure, SponsorDetailEntity>> getSponsorDetail(
      int payload) async {
    return await sponsorRepository.getSponsorDetail(payload);
  }

  Future<Either<Failure, List<StoreCheckinEntity>>> getListStoreCheckin(
      int payload) async {
    return await sponsorRepository.getListStoreCheckin(payload);
  }
}
