enum ViewState {
  idle,
  fetching,
  busy,
  success,
  failed,
  error,
  pagination,
  noData,
  authenticate
}

extension ViewStateValues on ViewState {
  get isFetching {
    return this == ViewState.fetching ? true : false;
  }

  get isError {
    return this == ViewState.error ? true : false;
  }

  get isNoDataOrError {
    return (this == ViewState.noData || this == ViewState.error) ? true : false;
  }
}

class ScreenState {
  ViewState? viewState;
  ScreenState({this.viewState});
  ScreenState copyWith({ViewState? viewState}) {
    return ScreenState(viewState: viewState ?? this.viewState);
  }
}
