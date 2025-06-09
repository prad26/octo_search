import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:octo_search/core/widgets/index.dart';

/// A reusable widget for displaying an infinitely scrolling list with built-in
/// pagination, loading, error, and empty states.
///
/// This widget leverages the `infinite_scroll_pagination` package to efficiently
/// load and display paginated data of type [T]. It provides customizable
/// builders for items, loading indicators, error messages, and no data states.
class InfiniteScrollList<T> extends StatelessWidget {
  /// An optional name for the items being displayed (e.g., "users", "repositories").
  /// Used in default loading/error messages. Defaults to "data".
  final String? itemName;

  /// The [PagingController] from `infinite_scroll_pagination` that manages
  /// the state and data fetching for the list.
  final PagingController<int, T> controller;

  /// An optional [ScrollController] to be attached to the underlying [PagedListView].
  final ScrollController? scrollController;

  /// A function responsible for fetching a page of data.
  ///
  /// It takes an integer `pageKey` (the page number) and should return a
  /// [FutureOr] of a list of items of type [T].
  final FutureOr<List<T>> Function(int pageKey) fetchPage;

  /// A builder function to create the widget for each item in the list.
  ///
  /// It provides the [BuildContext], the `index` of the item, the `item` data,
  /// and the total `itemsLength` currently loaded.
  final Widget Function(BuildContext context, int index, T item, int itemsLength) itemBuilder;

  /// An optional builder function to display a custom widget when no items are found.
  ///
  /// If not provided, a default [NoData] widget is shown.
  final Widget Function(BuildContext context)? noItemsFoundIndicatorBuilder;

  const InfiniteScrollList({
    super.key,
    this.itemName,
    required this.controller,
    this.scrollController,
    required this.fetchPage,
    required this.itemBuilder,
    this.noItemsFoundIndicatorBuilder,
  });

  /// The name to use for items in messages, defaulting to "data" if [itemName] is null.
  String get _itemName => itemName ?? 'data';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => controller.refresh()),
      child: PagingListener(
        controller: controller,
        builder: (context, state, fetchNextPage) {
          return PagedListView<int, T>(
            scrollController: scrollController,
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate<T>(
              itemBuilder: (context, item, index) {
                return itemBuilder(context, index, item, state.items?.length ?? 0);
              },
              noItemsFoundIndicatorBuilder: (context) {
                if (noItemsFoundIndicatorBuilder != null) {
                  return noItemsFoundIndicatorBuilder!(context);
                }

                return NoData(
                  message: 'No $_itemName found',
                  icon: Icons.search_off_rounded,
                );
              },
              firstPageProgressIndicatorBuilder: (context) => Loading(message: 'Loading $_itemName...'),
              newPageProgressIndicatorBuilder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Loading(message: 'Loading more $_itemName...'),
                );
              },
              firstPageErrorIndicatorBuilder: (context) {
                if (state.items?.isNotEmpty == true) {
                  return const SizedBox.shrink();
                }

                return ErrorMessage(
                  message: 'Failed to load $_itemName',
                  onRetry: () => controller.refresh(),
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: ErrorMessage(
                    message: 'Failed to load more $_itemName',
                    onRetry: () => controller.refresh(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
