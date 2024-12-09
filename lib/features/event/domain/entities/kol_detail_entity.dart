import 'package:equatable/equatable.dart';

class KOLDetailEntity extends Equatable {
  final int id;
  final int active;
  final String photo;
  final String photoThumb;
  final String number;
  final String name;
  final String gender;
  final String address;
  final String? description;
  final String info;
  final DateTime dob;
  final DateTime createdTime;
  final int? isVotingEnabled;
  final int? toTalVote;
  final int catagoryId;
  final List<dynamic> kolVotes;
  final String? catagory;
  final int? totalVotesPerKol;
  final int? indexTotalVotesPerKol;

  const KOLDetailEntity(
      {required this.id,
      required this.active,
      required this.photo,
      required this.photoThumb,
      required this.number,
      required this.name,
      required this.gender,
      required this.address,
      this.description,
      required this.info,
      required this.dob,
      required this.createdTime,
      this.isVotingEnabled,
      this.toTalVote,
      required this.catagoryId,
      required this.kolVotes,
      this.catagory,
      this.totalVotesPerKol,
      this.indexTotalVotesPerKol});

  @override
  List<Object?> get props => [
        id,
        active,
        photo,
        photoThumb,
        number,
        name,
        gender,
        address,
        description,
        info,
        dob,
        createdTime,
        isVotingEnabled,
        toTalVote,
        catagoryId,
        kolVotes,
        catagory,
        totalVotesPerKol,
        indexTotalVotesPerKol
      ];
}
