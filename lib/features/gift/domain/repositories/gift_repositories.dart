import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/event_gift_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_account_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_entity.dart';

abstract class GiftRepository {
  Future<Either<Failure, List<GiftEntity>>> getListGiftOfEvent(int payload);
  Future<Either<Failure, List<GiftAccountEntity>>> getListGiftOfAccount();
  Future<Either<Failure, List<EventGiftEntity>>> getListEventGift(int payload);
}
