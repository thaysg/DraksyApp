class PaginatedState<T> {
  const PaginatedState({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.initialError,
    this.paginationError,
  });

  factory PaginatedState.initial() => PaginatedState<T>(
        items: [],
        isLoading: true,
        isLoadingMore: false,
        hasMore: true,
      );
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;

  /// Error to load initial data (empty list).
  final String? initialError;

  /// Error when paginating (list already has items).
  final String? paginationError;

  // Sentinel: distinguishes "don't want to change" from "want to set null".
  static const Object _absent = Object();

  PaginatedState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    Object? initialError = _absent,
    Object? paginationError = _absent,
  }) =>
      PaginatedState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        initialError: initialError == _absent
            ? this.initialError
            : initialError as String?,
        paginationError: paginationError == _absent
            ? this.paginationError
            : paginationError as String?,
      );
}
