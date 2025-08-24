import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/base_state.dart';
import '../../../../../domain/entity/video/video_entity.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../bloc/info/video_cubit.dart';
import '../../../../widget/base_page.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('VIDEO EDUKASI')),
      body: BlocBuilder<VideoCubit, BaseState<List<VideoEntity>>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(child: Text('Empty Data'));
          }
          if (state.isSuccess) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final video = state.data![index];
                return ListTile(
                  title: Text(video.title),
                  trailing: Icon(
                    Icons.play_circle,
                    size: 45.h,
                    color: ColorName.primary,
                  ),
                  onTap: () async {
                    await launchUrl(Uri.parse(video.url));
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
              itemCount: state.data!.length,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
