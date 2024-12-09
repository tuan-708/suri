import 'package:equatable/equatable.dart';

// Entity
class TicketInfoEntity extends Equatable {
  final String eventName;
  final String accountName;
  final String eventAccountTypeName;
  final String? accountPhone;
  final String eventPhoto;
  final String eventBanner;
  final String eventBannerBase64;
  final String? addressEvent;
  final int rankId;
  final DateTime startDate;
  final DateTime endDate;
  final String eventInfo;
  final bool? isCheckin;
  final bool? isCheckedGift;
  final DateTime? timeCheckin;
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
  final String phone;
  final String? photo;
  final DateTime createdTime;
  final String gmail;
  final String? note;
  final String? relationship;
  final dynamic account;
  final dynamic event;
  final dynamic eventAccountType;
  final List<dynamic> eventAccountCheckins;

  const TicketInfoEntity({
    required this.eventName,
    required this.accountName,
    required this.eventAccountTypeName,
    this.accountPhone,
    required this.eventPhoto,
    required this.eventBanner,
    required this.eventBannerBase64,
    this.addressEvent,
    required this.rankId,
    required this.startDate,
    required this.endDate,
    required this.eventInfo,
    this.isCheckin,
    this.isCheckedGift,
    this.timeCheckin,
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
    required this.phone,
    this.photo,
    required this.createdTime,
    required this.gmail,
    this.note,
    this.relationship,
    this.account,
    this.event,
    this.eventAccountType,
    required this.eventAccountCheckins,
  });

  @override
  List<Object?> get props => [
        eventName,
        accountName,
        eventAccountTypeName,
        accountPhone,
        eventPhoto,
        eventBanner,
        eventBannerBase64,
        addressEvent,
        rankId,
        startDate,
        endDate,
        eventInfo,
        isCheckin,
        isCheckedGift,
        timeCheckin,
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
