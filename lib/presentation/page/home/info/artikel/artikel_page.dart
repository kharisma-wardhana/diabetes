import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/base_state.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/injector/service_locator.dart';
import '../../../../../domain/entity/article/article_entity.dart';
import '../../../../bloc/info/article_cubit.dart';
import '../../../../widget/base_page.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleCubit, BaseState<dynamic>>(
      listener: (context, state) {
        if (state.isError) {
          Fluttertoast.showToast(
            msg: state.errorMessage ?? "Unknown Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return const Text('Empty Data');
        }
        return BasePage(
          isLoading: state.isLoading,
          appBar: AppBar(title: const Text('ARTIKEL')),
          body: ListView.separated(
            itemCount: (state.data as List<ArticleEntity>).length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, thickness: 1, color: Colors.grey),
            itemBuilder: (context, index) {
              final article = (state.data as List<ArticleEntity>)[index];
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: ListTile(
                  title: Text(article.title),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    sl<AppNavigator>().pushNamed(
                      detailArticlePage,
                      arguments: article,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
