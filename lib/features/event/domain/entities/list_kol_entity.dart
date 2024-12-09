import 'package:equatable/equatable.dart';

class ListKOLEntity extends Equatable {
  final int key;
  final List<KOLDetailsEntity> value;

  const ListKOLEntity({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class KOLDetailsEntity extends Equatable {
  final int totalVotesPerKol;
  final String catagoryName;
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

  const KOLDetailsEntity({
    required this.totalVotesPerKol,
    required this.catagoryName,
    required this.id,
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
  });

  @override
  List<Object?> get props => [
        totalVotesPerKol,
        catagoryName,
        id,
        active,
        photo,
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
      ];
}
