class EventRegisterPayload {
  final String? Name;
  final String? Info;
  final String? Note;
  final String? Description;
  final String? Gmail;
  final int? TypeAccount;
  final String? Address;
  final int? EventId;
  final String? Phone;
  final int? EventAccountTypeId;
  const EventRegisterPayload(
      {this.Name,
      this.Info,
      this.Note,
      this.Description,
      this.Gmail,
      this.TypeAccount,
      this.Address,
      this.EventId,
      this.Phone,
      this.EventAccountTypeId});
  EventRegisterPayload copyWith(
      {String? Name,
      String? Info,
      String? Note,
      String? Description,
      String? Gmail,
      int? typeAccount,
      String? Address,
      int? EventId,
      String? Phone,
      int? EventAccountTypeId}) {
    return EventRegisterPayload(
        Name: Name ?? this.Name,
        Info: Info ?? this.Info,
        Note: Note ?? this.Note,
        Description: Description ?? this.Description,
        Gmail: Gmail ?? this.Gmail,
        TypeAccount: typeAccount ?? TypeAccount,
        Address: Address ?? this.Address,
        EventId: EventId ?? this.EventId,
        Phone: Phone ?? this.Phone,
        EventAccountTypeId: EventAccountTypeId ?? this.EventAccountTypeId);
  }

  Map<String, Object?> toJson() {
    return {
      'Name': Name,
      'Info': Info,
      'Note': Note,
      'Description': Description,
      'Gmail': Gmail,
      'TypeAccount': TypeAccount,
      'Address': Address,
      'EventId': EventId,
      'Phone': Phone,
      'EventAccountTypeId': EventAccountTypeId
    };
  }

  static EventRegisterPayload fromJson(Map<String, Object?> json) {
    return EventRegisterPayload(
        Name: json['Name'] == null ? null : json['Name'] as String,
        Info: json['Info'] == null ? null : json['Info'] as String,
        Note: json['Note'] == null ? null : json['Note'] as String,
        Description:
            json['Description'] == null ? null : json['Description'] as String,
        Gmail: json['Gmail'] == null ? null : json['Gmail'] as String,
        TypeAccount:
            json['TypeAccount'] == null ? null : json['TypeAccount'] as int,
        Address: json['Address'] == null ? null : json['Address'] as String,
        EventId: json['EventId'] == null ? null : json['EventId'] as int,
        Phone: json['Phone'] == null ? null : json['Phone'] as String,
        EventAccountTypeId: json['EventAccountTypeId'] == null
            ? null
            : json['EventAccountTypeId'] as int);
  }
}
