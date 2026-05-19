class PaginationRequest {
  const PaginationRequest({
    required this.page,
    this.limit = 20,
  });
  final int page;
  final int limit;

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
      };

  PaginationRequest copyWith({
    int? page,
    int? limit,
  }) =>
      PaginationRequest(
        page: page ?? this.page,
        limit: limit ?? this.limit,
      );
}
