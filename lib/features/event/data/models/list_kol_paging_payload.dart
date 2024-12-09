class ListKOLPagingPayload {
  int? pageIndex;
  int? pageSize;
  int? categoryId;
  ListKOLPagingPayload({this.pageIndex, this.pageSize, this.categoryId});
  ListKOLPagingPayload copyWith(
      {int? pageIndex, int? pageSize, int? categoryId}) {
    return ListKOLPagingPayload(
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'pageIndex': pageIndex,
      'pageSize': pageSize,
      'categoryId': categoryId
    };
  }

  static ListKOLPagingPayload fromJson(Map<String, Object?> json) {
    return ListKOLPagingPayload(
        pageIndex: json['pageIndex'] == null ? null : json['pageIndex'] as int,
        categoryId:
            json['categoryId'] == null ? null : json['categoryId'] as int,
        pageSize: json['pageSize'] == null ? null : json['pageSize'] as int);
  }
}
