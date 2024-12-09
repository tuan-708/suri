class SearchingKOLPayload {
  final String? keyword;
  final int? categoryId;
  const SearchingKOLPayload({
    this.keyword,
    this.categoryId,
  });
  SearchingKOLPayload copyWith({
    String? keyword,
    int? categoryId,
  }) {
    return SearchingKOLPayload(
      keyword: keyword ?? this.keyword,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'keyword': keyword,
      'categoryId': categoryId,
    };
  }

  static SearchingKOLPayload fromJson(Map<String, Object?> json) {
    return SearchingKOLPayload(
      keyword: json['keyword'] == null ? null : json['keyword'] as String,
      categoryId: json['categoryId'] == null ? null : json['categoryId'] as int,
    );
  }
}
