import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/base_state.dart';
import '../../../core/connectivity_manager.dart';
import '../../../core/constant.dart';
import '../../../data/model/user/user.dart';
import '../../../domain/entity/user/user_entity.dart';
import '../../../domain/usecase/auth/login_usecase.dart';
import '../../../domain/usecase/auth/register_usecase.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, BaseState<UserEntity>>
    with ConnectivityAwareMixin
    implements ConnectivityAware {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final FlutterSecureStorage secureStorage;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.secureStorage,
  }) : super(const BaseState.initial()) {
    // Register for connectivity updates
    registerForConnectivityUpdates();
    on<LoginEvent>((event, emit) async {
      emit(const BaseState.loading());
      try {
        final result = await loginUsecase.call({
          'email': event.username,
          'password': event.password,
        });
        result.fold(
          (failure) => emit(
            BaseState.error(
              message: failure.message.isNotEmpty
                  ? failure.message
                  : 'Login failed. Please check your credentials and try again.',
            ),
          ),
          (user) {
            secureStorage.write(
              key: tokenKey,
              value: jsonEncode(user.toJson()),
            );
            secureStorage.write(key: userIDKey, value: user.id.toString());
            emit(BaseState.success(data: user));
          },
        );
      } catch (e) {
        emit(BaseState.error(message: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) {
      secureStorage.delete(key: tokenKey);
      secureStorage.delete(key: userIDKey);
      emit(const BaseState.initial());
    });

    on<RegisterEvent>((event, emit) async {
      emit(const BaseState.loading());
      try {
        final result = await registerUsecase.call({
          'name': event.name,
          'email': event.email,
          'mobile': event.mobile,
          'dob': event.dob,
          'gender': event.gender,
        });
        result.fold(
          (failure) => emit(BaseState.error(message: failure.message)),
          (user) {
            secureStorage.write(key: tokenKey, value: jsonEncode(user));
            secureStorage.write(key: userIDKey, value: user.id.toString());
            emit(BaseState.success(data: user));
          },
        );
      } catch (e) {
        emit(BaseState.error(message: e.toString()));
      }
    });

    on<AppStarted>((event, emit) async {
      emit(const BaseState.loading());
      final token = await secureStorage.read(key: tokenKey);
      if (token != null) {
        try {
          final userJson = jsonDecode(token);
          final user = User.fromJson(userJson);
          emit(BaseState.success(data: user.toEntity()));
        } catch (e) {
          emit(const BaseState.initial());
        }
      } else {
        emit(const BaseState.initial());
      }
    });

    on<CompleteOnboardingEvent>((event, emit) async {
      if (state.isSuccess) {
        final currentUser = state.data!;
        final updatedUser = currentUser.copyWith(isOnboardingComplete: true);

        // Update the user in secure storage
        await secureStorage.delete(key: tokenKey);
        // Write the updated user back to secure storage
        await secureStorage.write(
          key: tokenKey,
          value: jsonEncode(updatedUser.toJson()),
        );
        await secureStorage.write(
          key: userIDKey,
          value: updatedUser.id.toString(),
        );
        emit(BaseState.success(data: updatedUser));
      } else {
        emit(const BaseState.initial());
      }
    });

    on<CompleteAntropometriEvent>((event, emit) async {
      if (state.isSuccess) {
        final currentUser = state.data!;
        final updatedUser = currentUser.copyWith(isAntropometriComplete: true);

        // Update the user in secure storage
        await secureStorage.delete(key: tokenKey);
        // Write the updated user back to secure storage
        await secureStorage.write(
          key: tokenKey,
          value: jsonEncode(updatedUser.toJson()),
        );
        await secureStorage.write(
          key: userIDKey,
          value: updatedUser.id.toString(),
        );
        emit(BaseState.success(data: updatedUser));
      } else {
        emit(const BaseState.initial());
      }
    });
  }

  // ConnectivityAware implementation
  @override
  void onConnectivityRestored() {
    // Re-trigger authentication check when connectivity is restored
    add(const AuthEvent.appStarted());
  }

  @override
  void onConnectivityLost() {
    // Optional: Handle connectivity loss if needed
    // For now, we don't need to do anything specific
  }

  @override
  void onConnectivityChanged(bool isConnected) {
    // Optional: Handle general connectivity changes if needed
    // The specific onConnectivityRestored method will handle what we need
  }

  @override
  Future<void> close() {
    // Unregister from connectivity updates
    unregisterFromConnectivityUpdates();
    return super.close();
  }
}
