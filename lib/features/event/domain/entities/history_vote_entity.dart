import 'package:equatable/equatable.dart';

class HistoryVoteEntity extends Equatable {
  final String? accountName;
  final String? accountVotingId;
  final String? kolName;
  final String? kolPhoneNumber;
  final String? kolEmail;
  final String? kolAddress;
  final DateTime? voteDate;
  final int? totalVotes;

  const HistoryVoteEntity({
    required this.accountName,
    required this.accountVotingId,
    this.kolName,
    this.kolPhoneNumber,
    this.kolEmail,
    this.kolAddress,
    required this.voteDate,
    required this.totalVotes,
  });

  @override
  List<Object?> get props => [
        accountName,
        accountVotingId,
        kolName,
        kolPhoneNumber,
        kolEmail,
        kolAddress,
        voteDate,
        totalVotes,
      ];
}
