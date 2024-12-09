import 'package:equatable/equatable.dart';

class RemainingVotesEntity extends Equatable {
  final int remainingVotes;

  const RemainingVotesEntity({
    required this.remainingVotes,
  });

  @override
  List<Object?> get props => [remainingVotes];
}
