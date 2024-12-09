import 'package:suri_checking_event_app/features/event/domain/entities/remaining_votes_entity.dart';

class RemainingVotesModel extends RemainingVotesEntity {
  const RemainingVotesModel({
    required int remainingVotes,
  }) : super(
          remainingVotes: remainingVotes,
        );

  factory RemainingVotesModel.fromJson(Map<String, dynamic> json) {
    return RemainingVotesModel(
      remainingVotes: json['remainingVotes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remainingVotes': remainingVotes,
    };
  }
}
