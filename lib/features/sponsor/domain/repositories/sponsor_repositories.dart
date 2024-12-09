import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_sponsor_payload.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_detail_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/store_checkin_entity.dart';

abstract class SponsorRepository {
  Future<Either<Failure, List<SponsorEntity>>> getListSponsors(
      ListSponsorsPayload payload);

  Future<Either<Failure, SponsorDetailEntity>> getSponsorDetail(int payload);

  Future<Either<Failure, List<StoreCheckinEntity>>> getListStoreCheckin(
      int payload);
}
