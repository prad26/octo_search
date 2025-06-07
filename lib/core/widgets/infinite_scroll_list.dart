import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:octo_search/core/widgets/error_message.dart';
import 'package:octo_search/core/widgets/loading.dart';
import 'package:octo_search/core/widgets/no_data.dart';

/// A reusable infinite scrolling list with built-in pagination.
///
/// This widget handles loading, error states, and empty states for
/// paginated data. It uses the infinite_scroll_pagination package
/// to efficiently load and display paginated data.
class InfiniteScrollList<T> extends StatelessWidget {
  final String? itemName;
  final PagingController<int, T> controller;
  final ScrollController? scrollController;
  final FutureOr<List<T>> Function(int pageKey) fetchPage;
  final Widget Function(BuildContext context, int index, T item, int itemsLength) itemBuilder;
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
