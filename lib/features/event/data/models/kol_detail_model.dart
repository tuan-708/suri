import 'package:suri_checking_event_app/features/event/domain/entities/kol_detail_entity.dart';

class KOLDetailModel extends KOLDetailEntity {
  const KOLDetailModel({
    required int id,
    required int active,
    required String photo,
    required String photoThumb,
    required String number,
    required String name,
    required String gender,
    required String address,
    String? description,
    required String info,
    required DateTime dob,
    required DateTime createdTime,
    int? isVotingEnabled,
    int? toTalVote,
    required int catagoryId,
    required List<dynamic> kolVotes,
    int? totalVotesPerKol,
    int? indexTotalVotesPerKol,
    String? catagory,
  }) : super(
            id: id,
            active: active,
            photo: photo,
            photoThumb: photoThumb,
            number: number,
            name: name,
            gender: gender,
            address: address,
            description: description,
            info: info,
            dob: dob,
            createdTime: createdTime,
            isVotingEnabled: isVotingEnabled,
            toTalVote: toTalVote,
            catagoryId: catagoryId,
            kolVotes: kolVotes,
            catagory: catagory,
            totalVotesPerKol: totalVotesPerKol,
            indexTotalVotesPerKol: indexTotalVotesPerKol);

  factory KOLDetailModel.fromJson(Map<String, dynamic> json) {
    return KOLDetailModel(
        id: json['id'],
        active: json['active'],
        photo: json['photo'] ?? '',
        photoThumb: json['photoThumb'] ?? '',
        number: json['number'] ?? '',
        name: json['name'] ?? '',
        gender: json['gender'] ?? '',
        address: json['address'] ?? '',
        description: json['description'] ?? '',
        info: json['info'] ?? '',
        dob: DateTime.parse(json['dob']),
        createdTime: DateTime.parse(json['createdTime']),
        isVotingEnabled: json['isVotingEnabled'] ?? 1,
        toTalVote: json['toTalVote'] ?? 0,
        catagoryId: json['catagoryId'] ?? 0,
        kolVotes: List<dynamic>.from(json['kolVotes']),
        catagory: json['catagory'] ?? '',
        totalVotesPerKol: json['totalVotesPerKol'] ?? 0,
        indexTotalVotesPerKol: json['indexTotalVotesPerKol'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'photo': photo,
      'photoThumb': photoThumb,
      'number': number,
      'name': name,
      'gender': gender,
      'address': address,
      'description': description,
      'info': info,
      'dob': dob.toIso8601String(),
      'createdTime': createdTime.toIso8601String(),
      'isVotingEnabled': isVotingEnabled,
      'toTalVote': toTalVote,
      'catagoryId': catagoryId,
      'kolVotes': kolVotes,
      'catagory': catagory,
      'totalVotesPerKol': totalVotesPerKol,
      'indexTotalVotesPerKol': indexTotalVotesPerKol
    };
  }
}
