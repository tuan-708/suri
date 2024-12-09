class HistoryVotePayload {
  int? kolId;
  int? pageIndex;
  int? pageSize;
  HistoryVotePayload({this.kolId, this.pageIndex, this.pageSize});
  HistoryVotePayload copyWith({int? kolId, int? pageIndex, int? pageSize}) {
    return HistoryVotePayload(
        kolId: kolId ?? this.kolId,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize);
  }

  Map<String, Object?> toJson() {
    return {'kolId': kolId, 'pageIndex': pageIndex, 'pageSize': pageSize};
  }

  static HistoryVotePayload fromJson(Map<String, Object?> json) {
    return HistoryVotePayload(
        kolId: json['kolId'] == null ? null : json['kolId'] as int,
        pageIndex: json['pageIndex'] == null ? null : json['pageIndex'] as int,
        pageSize: json['pageSize'] == null ? null : json['pageSize'] as int);
  }
}
