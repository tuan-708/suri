class ListEventsPayload {
  int? pageIndex;
  int? pageSize;
  int? statusId;
  ListEventsPayload({this.pageIndex, this.pageSize, this.statusId});
  ListEventsPayload copyWith({int? pageIndex, int? pageSize, int? statusId}) {
    return ListEventsPayload(
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      statusId: statusId ?? this.statusId,
    );
  }

  Map<String, Object?> toJson() {
    return {'pageIndex': pageIndex, 'pageSize': pageSize, 'statusId': statusId};
  }

  static ListEventsPayload fromJson(Map<String, Object?> json) {
    return ListEventsPayload(
        pageIndex: json['pageIndex'] == null ? null : json['pageIndex'] as int,
        statusId: json['statusId'] == null ? null : json['statusId'] as int,
        pageSize: json['pageSize'] == null ? null : json['pageSize'] as int);
  }
}
