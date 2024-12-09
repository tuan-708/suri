import 'package:equatable/equatable.dart';

class TicketSpecialInfoEntity extends Equatable {
  final String eventName;
  final String? accountName;
  final String? accountPhoto;
  final String? eventAccountTypeName;
  final String? accountPhone;
  final String? eventPhoto;
  final String? eventBanner;
  final String? eventBannerBase64;
  final String? addressEvent;
  final int? rankId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? eventInfo;
  final bool? isCheckin;
  final bool? isCheckedGift;
  final bool? isSpecialEvent;
  final DateTime? timeCheckin;
  final int id;
  final int active;
  final String? name;
  final String? info;
  final String? description;
  final int eventId;
  final int accountId;
  final int eventAccountTypeId;
  final String? typeAccount;
  final String? address;
  final String? phone;
  final String? photo;
  final DateTime? createdTime;
  final String? gmail;
  final String? note;
  final String? relationship;
  final String? account;
  final String? event;
  final String? eventAccountType;
  final List<dynamic> eventAccountCheckins;

  const TicketSpecialInfoEntity({
    required this.eventName,
    this.accountName,
    this.accountPhoto,
    this.eventAccountTypeName,
    this.accountPhone,
    this.eventPhoto,
    this.eventBanner,
    this.eventBannerBase64,
    this.addressEvent,
    this.rankId,
    this.startDate,
    this.endDate,
    this.eventInfo,
    this.isCheckin,
    this.isCheckedGift,
    this.isSpecialEvent,
    this.timeCheckin,
    required this.id,
    required this.active,
    this.name,
    this.info,
    this.description,
    required this.eventId,
    required this.accountId,
    required this.eventAccountTypeId,
    this.typeAccount,
    this.address,
    this.phone,
    this.photo,
    this.createdTime,
    this.gmail,
    this.note,
    this.relationship,
    this.account,
    this.event,
    this.eventAccountType,
    this.eventAccountCheckins = const [],
  });

  @override
  List<Object?> get props => [
        eventName,
        accountName,
        accountPhoto,
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
        isSpecialEvent,
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
