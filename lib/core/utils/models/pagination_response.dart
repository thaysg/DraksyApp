class PaginationResponse<T> {
  const PaginationResponse({
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.lastPage,
  });

  factory PaginationResponse.empty() => const PaginationResponse(
        items: [],
        totalCount: 0,
        currentPage: 0,
        lastPage: 0,
      );
  final List<T> items;
  final int totalCount;
  final int currentPage;
  final int lastPage;

  bool get hasMore => currentPage < lastPage;
}
