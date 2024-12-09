class ListSponsorsPayload {
  final int? pageIndex;
  final int? pageSize;
  const ListSponsorsPayload({this.pageIndex, this.pageSize});
  ListSponsorsPayload copyWith({int? pageIndex, int? pageSize}) {
    return ListSponsorsPayload(
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize);
  }

  Map<String, Object?> toJson() {
    return {'pageIndex': pageIndex, 'pageSize': pageSize};
  }

  static ListSponsorsPayload fromJson(Map<String, Object?> json) {
    return ListSponsorsPayload(
        pageIndex: json['pageIndex'] == null ? null : json['pageIndex'] as int,
        pageSize: json['pageSize'] == null ? null : json['pageSize'] as int);
  }
}
