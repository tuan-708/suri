import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_sponsor_payload.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_detail_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/sponsor_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/data/datasources/sponsor_remote_data_source.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/entities/store_checkin_entity.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/repositories/sponsor_repositories.dart';

class SponsorRepositoryImpl implements SponsorRepository {
  final SponsorRemoteDataSource sponsorRemoteDataSource;
  SponsorRepositoryImpl({required this.sponsorRemoteDataSource});

  @override
  Future<Either<Failure, List<SponsorEntity>>> getListSponsors(
      ListSponsorsPayload payload) async {
    try {
      final sponsors = await sponsorRemoteDataSource.getListSponsors(payload);
      return right(sponsors);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SponsorDetailEntity>> getSponsorDetail(
      int payload) async {
    try {
      final sponsorDetail =
          await sponsorRemoteDataSource.getSponsorDetail(payload);
      return right(sponsorDetail);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StoreCheckinEntity>>> getListStoreCheckin(
      int payload) async {
    try {
      final stores = await sponsorRemoteDataSource.getListStoreCheckin(payload);
      return right(stores);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
