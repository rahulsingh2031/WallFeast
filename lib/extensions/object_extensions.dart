extension TryCast on Object? {
  T? tryCast<T>() {
    return this is T ? this as T : null;
  }
}