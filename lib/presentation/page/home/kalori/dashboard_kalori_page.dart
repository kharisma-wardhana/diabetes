import 'package:diabetes/core/constant.dart';
import 'package:diabetes/presentation/bloc/kalori/kalori_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../bloc/kalori/kalori_bloc.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_scrollable.dart';
import 'widget/kalori_data.dart';

class DashboardKaloriPage extends StatefulWidget {
  const DashboardKaloriPage({super.key});

  @override
  State<DashboardKaloriPage> createState() => _DashboardKaloriPageState();
}

class _DashboardKaloriPageState extends State<DashboardKaloriPage> {
  Future<void> _onRefresh() async {
    final currentDate = DateTime.now().toIso8601String();
    context.read<KaloriBloc>().add(KaloriFetched(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<KaloriBloc, BaseState<KaloriEntity>>(
        builder: (context, state) {
          if (state.isInitial || state.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Tidak mempunyai data'),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      textButton: 'Buat Data Kalori',
                      onTap: () {
                        sl<AppNavigator>().pushNamed(kaloriPage);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text('Error: ${state.errorMessage}'),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      textButton: 'Coba Lagi',
                      onTap: _onRefresh,
                    ),
                  ),
                ],
              ),
            );
          } else if (state.isSuccess) {
            return CustomScrollable(child: KaloriData());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
