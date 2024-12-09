import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/event_gift_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_account_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/entities/gift_entity.dart';
import 'package:suri_checking_event_app/features/gift/domain/repositories/gift_repositories.dart';

class GiftUseCases {
  final GiftRepository giftRepository;
  GiftUseCases({required this.giftRepository});

  Future<Either<Failure, List<GiftEntity>>> getListGiftOfEvent(
      int payload) async {
    return await giftRepository.getListGiftOfEvent(payload);
  }

  Future<Either<Failure, List<GiftAccountEntity>>>
      getListGiftOfAccount() async {
    return await giftRepository.getListGiftOfAccount();
  }

  Future<Either<Failure, List<EventGiftEntity>>> getListEventGift(
      payload) async {
    return await giftRepository.getListEventGift(payload);
  }
}
