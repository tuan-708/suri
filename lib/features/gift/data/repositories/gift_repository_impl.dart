import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/gift/data/datasources/gift_remote_date_source.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/event_gift_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_account_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/repositories/gift_repositories.dart';

class GiftRepositoryImpl implements GiftRepository {
  final GiftRemoteDataSource giftRemoteDataSource;
  GiftRepositoryImpl({required this.giftRemoteDataSource});

  @override
  Future<Either<Failure, List<GiftEntity>>> getListGiftOfEvent(
      int payload) async {
    try {
      final gifts = await giftRemoteDataSource.getListGiftOfEvent(payload);
      return right(gifts);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GiftAccountEntity>>>
      getListGiftOfAccount() async {
    try {
      final gifts = await giftRemoteDataSource.getListGiftOfAccount();
      return right(gifts);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EventGiftEntity>>> getListEventGift(
      int payload) async {
    try {
      final gifts = await giftRemoteDataSource.getListEventGift(payload);
      return right(gifts);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
