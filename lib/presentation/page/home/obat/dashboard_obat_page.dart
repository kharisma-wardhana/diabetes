import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_state.dart';
import '../../../widget/custom_scrollable.dart';

class DashboardObatPage extends StatefulWidget {
  const DashboardObatPage({super.key});

  @override
  State<DashboardObatPage> createState() => _DashboardObatPageState();
}

class _DashboardObatPageState extends State<DashboardObatPage> {
  Future<void> _onRefresh() async {
    context.read<ObatCubit>().fetchObatData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<ObatCubit, BaseState<List<ObatEntity>>>(
        builder: (context, state) {
          if (state.isError) {
            return Center(child: Text(state.errorMessage ?? 'Unknown error'));
          } else if (state.isSuccess) {
            final obatList = state.data;
            return CustomScrollable(child: Text("a"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
