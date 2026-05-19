import '../models/pagination_request.dart';
import '../models/pagination_response.dart';
import 'paginated_state.dart';

typedef PageFetcher<T> = Future<PaginationResponse<T>> Function(
  PaginationRequest request,
);

mixin PaginatedNotifierMixin<T> {
  PaginatedState<T> get state;
  set state(PaginatedState<T> value);

  int _page = 1;
  int get limit => 20;

  /// The function that fetches a page of items.
  PageFetcher<T> get fetchPage;

  // ─────────────────────────────────────────────
  // Initial load
  // ─────────────────────────────────────────────

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      initialError: null,
      paginationError: null,
    );

    try {
      final response = await fetchPage(
        PaginationRequest(page: 1, limit: limit),
      );

      state = state.copyWith(
        items: response.items,
        isLoading: false,
        hasMore: response.hasMore,
      );

      _page = 2;
    } catch (e) {
      state = state.copyWith(isLoading: false, initialError: e.toString());
    }
  }

  // ─────────────────────────────────────────────
  // Pagination
  // ─────────────────────────────────────────────

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.isLoading || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoadingMore: true, paginationError: null);

    try {
      final response = await fetchPage(
        PaginationRequest(page: _page, limit: limit),
      );

      state = state.copyWith(
        items: [...state.items, ...response.items],
        hasMore: response.hasMore,
        isLoadingMore: false,
      );

      _page++;
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        paginationError: e.toString(),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Refresh
  // ─────────────────────────────────────────────

  Future<void> refresh() async {
    _page = 1;
    state = PaginatedState<T>.initial();
    await loadInitial();
  }
}
