import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_paging_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/searching_kol_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/history_vote_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/remaining_votes_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/repositories/kol_repositories.dart';

class KOLUseCases {
  final KOLRepository kolRepository;
  KOLUseCases({required this.kolRepository});

  Future<Either<Failure, List<ListKOLEntity>>> getListTop3KOL() async {
    return await kolRepository.getListTop3KOL();
  }

  Future<Either<Failure, List<HistoryVoteEntity>>> getListHistoryVote(
      HistoryVotePayload payload) async {
    return await kolRepository.getListHistoryVote(payload);
  }

  Future<Either<Failure, RemainingVotesEntity>> getRemainingVotes() async {
    return await kolRepository.getRemainingVotes();
  }

  Future<Either<Failure, bool>> postVoteKol(int payload) async {
    return await kolRepository.postVoteKol(payload);
  }

  Future<Either<Failure, List<KOLDetailEntity>>> getListKOLPaging(
      ListKOLPagingPayload payload) async {
    return await kolRepository.getListKOLPaging(payload);
  }

  Future<Either<Failure, List<KOLDetailEntity>>> getLitKOLSearching(
      SearchingKOLPayload payload) async {
    return await kolRepository.getLitKOLSearching(payload);
  }
}
