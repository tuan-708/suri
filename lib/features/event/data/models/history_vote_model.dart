import 'package:suri_checking_event_app/features/event/domain/entities/history_vote_entity.dart';

class HistoryVoteModel extends HistoryVoteEntity {
  const HistoryVoteModel({
    required String accountName,
    required String accountVotingId,
    String? kolName,
    String? kolPhoneNumber,
    String? kolEmail,
    String? kolAddress,
    required DateTime voteDate,
    required int totalVotes,
  }) : super(
          accountName: accountName,
          accountVotingId: accountVotingId,
          kolName: kolName,
          kolPhoneNumber: kolPhoneNumber,
          kolEmail: kolEmail,
          kolAddress: kolAddress,
          voteDate: voteDate,
          totalVotes: totalVotes,
        );

  factory HistoryVoteModel.fromJson(Map<String, dynamic> json) {
    return HistoryVoteModel(
      accountName: json['accountName'] ?? '',
      accountVotingId: json['accountVotingId'] ?? '',
      kolName: json['kolName'] ?? '',
      kolPhoneNumber: json['kolPhoneNumber'] ?? '',
      kolEmail: json['kolEmail'] ?? '',
      kolAddress: json['kolAddress'] ?? '',
      voteDate: DateTime.parse(json['voteDate']),
      totalVotes: json['totalVotes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'accountVotingId': accountVotingId,
      'kolName': kolName,
      'kolPhoneNumber': kolPhoneNumber,
      'kolEmail': kolEmail,
      'kolAddress': kolAddress,
      'voteDate': voteDate!.toIso8601String(),
      'totalVotes': totalVotes,
    };
  }
}
