import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_navigator.dart';
import '../../core/base_state.dart';
import '../../core/constant.dart';
import '../../core/injector/service_locator.dart';
import '../../domain/entity/user/user_entity.dart';
import '../bloc/assesment/obat_cubit.dart';
import '../bloc/auth/auth_bloc.dart';

/// Global widget that listens to AuthBloc state changes and handles navigation
/// This ensures navigation happens regardless of which page is currently active
class GlobalAuthListener extends StatelessWidget {
  final Widget child;

  const GlobalAuthListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, BaseState<UserEntity>>(
      listener: (context, state) {
        // Get current route to avoid unnecessary navigation
        final navigator = sl<AppNavigator>();
        final currentRoute = ModalRoute.of(context)?.settings.name;

        if (state.isSuccess) {
          final user = state.data as UserEntity;

          if (user.isOnboardingComplete != null && user.isOnboardingComplete!) {
            if (user.isAntropometriComplete != null &&
                user.isAntropometriComplete!) {
              // Don't auto-navigate if we're on specific pages that handle their own navigation
              if (currentRoute == gulaDarahPage ||
                  currentRoute == recommendationPage ||
                  currentRoute == activityPage ||
                  currentRoute == questionPage) {
                return; // Skip auto-navigation for these pages
              }

              // Only navigate if not already on home page
              if (currentRoute != homePage) {
                final now = DateTime.now().toIso8601String().split('T')[0];
                context.read<ObatCubit>().getAllMedicine(now);
                navigator.pushNamedAndRemoveUntil(homePage, arguments: 0);
              }
            } else {
              navigator.pushNamedAndRemoveUntil(antropometriPage);
            }
          } else {
            // Only navigate if not already on onboarding page
            if (currentRoute != onboardingPage) {
              navigator.pushNamedAndRemoveUntil(onboardingPage);
            }
          }
        } else if (state.isInitial) {
          // Only navigate if not already on login page
          if (currentRoute != loginPage) {
            navigator.pushNamedAndRemoveUntil(loginPage);
          }
        } else if (state.isError) {
          // Only navigate if not already on login page
          if (currentRoute != loginPage) {
            navigator.pushNamedAndRemoveUntil(loginPage);
          }
        }
      },
      child: child,
    );
  }
}
