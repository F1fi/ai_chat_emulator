class CustomResponse<T> {
  const CustomResponse({this.result, this.error});

  final T? result;
  final Exception? error;

  T? when({T Function(T)? onSuccess, T? Function(Exception)? onFail}) {
    if (result != null) {
      return onSuccess?.call(result as T);
    }

    if (error != null) {
      onFail?.call(error!);
    }

    return null;
  }
}
