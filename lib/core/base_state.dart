import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

@freezed
class BaseState<T> with _$BaseState<T> {
  const factory BaseState.initial() = BaseStateInitial<T>;

  const factory BaseState.loading([String? message]) = BaseStateLoading<T>;

  const factory BaseState.success({required T data, String? message}) =
      BaseStateSuccess<T>;

  const factory BaseState.error({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) = BaseStateError<T>;

  const factory BaseState.empty([String? message]) = BaseStateEmpty<T>;
}

// Extension for convenient checking
extension BaseStateExtensions<T> on BaseState<T> {
  bool get isInitial => this is BaseStateInitial<T>;
  bool get isLoading => this is BaseStateLoading<T>;
  bool get isSuccess => this is BaseStateSuccess<T>;
  bool get isError => this is BaseStateError<T>;
  bool get isEmpty => this is BaseStateEmpty<T>;

  T? get data => mapOrNull(success: (state) => state.data);
  String? get message => mapOrNull(
    loading: (state) => state.message,
    success: (state) => state.message,
    error: (state) => state.message,
    empty: (state) => state.message,
  );
  String? get errorMessage => mapOrNull(error: (state) => state.message);
}
