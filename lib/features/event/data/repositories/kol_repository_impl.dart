import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/features/event/data/datasources/kol_remote_date_source.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/history_vote_model.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_kol_paging_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/searching_kol_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/remaining_votes_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/repositories/kol_repositories.dart';

class KOLRepositoryImpl implements KOLRepository {
  final KOLRemoteDataSource kolRemoteDataSource;
  KOLRepositoryImpl({required this.kolRemoteDataSource});

  @override
  Future<Either<Failure, List<ListKOLEntity>>> getListTop3KOL() async {
    try {
      final listKOLTop3 = await kolRemoteDataSource.getListTop3KOL();
      return right(listKOLTop3);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HistoryVoteModel>>> getListHistoryVote(
      HistoryVotePayload payload) async {
    try {
      final histories = await kolRemoteDataSource.getListHistoryVote(payload);
      return right(histories);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RemainingVotesEntity>> getRemainingVotes() async {
    try {
      final remainingVotes = await kolRemoteDataSource.getRemainingVotes();
      return right(remainingVotes);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> postVoteKol(int payload) async {
    try {
      final vote = await kolRemoteDataSource.postVoteKol(payload);
      return right(vote);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KOLDetailEntity>>> getListKOLPaging(
      ListKOLPagingPayload payload) async {
    try {
      final listKOL = await kolRemoteDataSource.getListKOLPaging(payload);
      return right(listKOL);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KOLDetailEntity>>> getLitKOLSearching(
      SearchingKOLPayload payload) async {
    try {
      final listKOL = await kolRemoteDataSource.getLitKOLSearching(payload);
      return right(listKOL);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
