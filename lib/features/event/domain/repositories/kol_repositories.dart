import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_paging_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/searching_kol_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/history_vote_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/remaining_votes_entity.dart';

abstract class KOLRepository {
  Future<Either<Failure, List<ListKOLEntity>>> getListTop3KOL();
  Future<Either<Failure, List<HistoryVoteEntity>>> getListHistoryVote(
      HistoryVotePayload payload);
  Future<Either<Failure, RemainingVotesEntity>> getRemainingVotes();
  Future<Either<Failure, bool>> postVoteKol(int payload);
  Future<Either<Failure, List<KOLDetailEntity>>> getListKOLPaging(
      ListKOLPagingPayload payload);
  Future<Either<Failure, List<KOLDetailEntity>>> getLitKOLSearching(
      SearchingKOLPayload payload);
}
