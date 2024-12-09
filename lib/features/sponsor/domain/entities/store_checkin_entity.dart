import 'package:equatable/equatable.dart';

class StoreCheckinEntity extends Equatable {
  final int id;
  final String name;
  final String? photo;
  final String position;
  final String storeRankingName;
  final bool isChecked;
  final int? point;
  final DateTime? checkedTime;

  const StoreCheckinEntity({
    required this.id,
    required this.name,
    required this.photo,
    required this.position,
    required this.storeRankingName,
    required this.isChecked,
    this.point,
    this.checkedTime,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        photo,
        position,
        storeRankingName,
        isChecked,
        point,
        checkedTime,
      ];
}
