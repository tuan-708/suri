import 'package:equatable/equatable.dart';

class EventRegisterEntity extends Equatable {
  final int id;
  final int active;
  final String name;
  final String info;
  final String description;
  final int eventId;
  final int accountId;
  final int eventAccountTypeId;
  final int? typeAccount;
  final String? address;
  final String? phone;
  final String? photo;
  final DateTime createdTime;
  final String? gmail;
  final String? note;
  final String? relationship;
  final String? account;
  final String? event;
  final String? eventAccountType;
  final List<dynamic> eventAccountCheckins;

  const EventRegisterEntity({
    required this.id,
    required this.active,
    required this.name,
    required this.info,
    required this.description,
    required this.eventId,
    required this.accountId,
    required this.eventAccountTypeId,
    this.typeAccount,
    this.address,
    this.phone,
    this.photo,
    required this.createdTime,
    this.gmail,
    this.note,
    this.relationship,
    this.account,
    this.event,
    this.eventAccountType,
    required this.eventAccountCheckins,
  });

  @override
  List<Object?> get props => [
        id,
        active,
        name,
        info,
        description,
        eventId,
        accountId,
        eventAccountTypeId,
        typeAccount,
        address,
        phone,
        photo,
        createdTime,
        gmail,
        note,
        relationship,
        account,
        event,
        eventAccountType,
        eventAccountCheckins,
      ];
}
