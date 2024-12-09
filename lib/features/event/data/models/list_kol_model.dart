import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';

class ListKOLModel extends ListKOLEntity {
  const ListKOLModel({
    required int key,
    required List<KOLDetailsModel> value,
  }) : super(key: key, value: value);

  factory ListKOLModel.fromJson(Map<String, dynamic> json) {
    return ListKOLModel(
      key: json['key'],
      value: (json['value'] as List)
          .map((item) => KOLDetailsModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value.map((item) => (item as KOLDetailsModel).toJson()).toList(),
    };
  }
}

class KOLDetailsModel extends KOLDetailsEntity {
  const KOLDetailsModel({
    required int totalVotesPerKol,
    required String catagoryName,
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
    String? catagory,
  }) : super(
          totalVotesPerKol: totalVotesPerKol,
          catagoryName: catagoryName,
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
        );

  factory KOLDetailsModel.fromJson(Map<String, dynamic> json) {
    return KOLDetailsModel(
      totalVotesPerKol: json['totalVotesPerKol'] ?? 0,
      catagoryName: json['catagoryName'] ?? '',
      id: json['id'] ?? 0,
      active: json['active'] ?? 0,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalVotesPerKol': totalVotesPerKol,
      'catagoryName': catagoryName,
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
    };
  }
}
