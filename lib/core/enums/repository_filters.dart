/// Enum defining the available repository filters.
///
/// Used to filter repositories by their fork status.
enum RepositoryFilters {
  all,
  nonForked,
  forked,
}

extension RepositoryFiltersExtension on RepositoryFilters {
  /// Returns a user-friendly label for the filter.
  String get label {
    switch (this) {
      case RepositoryFilters.all:
        return 'All';
      case RepositoryFilters.nonForked:
        return 'Non-Forked';
      case RepositoryFilters.forked:
        return 'Forked';
    }
  }

  /// Returns the query parameter value for GitHub API.
  String get query {
    switch (this) {
      case RepositoryFilters.all:
        return 'fork:true';
      case RepositoryFilters.nonForked:
        return 'fork:false';
      case RepositoryFilters.forked:
        return 'fork:only';
    }
  }
}
