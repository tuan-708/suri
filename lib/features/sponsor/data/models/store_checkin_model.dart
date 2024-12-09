import 'package:suri_checking_event_app/features/sponsor/domain/entities/store_checkin_entity.dart';

class StoreCheckinModel extends StoreCheckinEntity {
  const StoreCheckinModel({
    required int id,
    required String name,
    required String? photo,
    required String position,
    required String storeRankingName,
    required bool isChecked,
    int? point,
    DateTime? checkedTime,
  }) : super(
          id: id,
          name: name,
          photo: photo,
          position: position,
          storeRankingName: storeRankingName,
          isChecked: isChecked,
          point: point,
          checkedTime: checkedTime,
        );

  factory StoreCheckinModel.fromJson(Map<String, dynamic> json) {
    return StoreCheckinModel(
      id: json['id'] as int,
      name: json['name'] as String,
      photo: json['photo'] == null ? null : json['photo'] as String,
      position: json['position'] as String,
      storeRankingName: json['storeRankingName'] as String,
      isChecked: json['isChecked'] as bool,
      point: json['point'] == null ? null : json['point'] as int,
      checkedTime: json['checkedTime'] != null
          ? DateTime.parse(json['checkedTime'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'position': position,
      'storeRankingName': storeRankingName,
      'isChecked': isChecked,
      'point': point,
      'checkedTime': checkedTime?.toIso8601String(),
    };
  }
}
