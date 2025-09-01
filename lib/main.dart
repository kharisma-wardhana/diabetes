import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_navigator.dart';
import 'core/app_router.dart';
import 'core/connectivity_handler.dart';
import 'core/connectivity_manager.dart';
import 'core/error_handler.dart';
import 'core/injector/service_locator.dart';
import 'gen/colors.gen.dart';
import 'presentation/bloc/activity/activity_bloc.dart';
import 'presentation/bloc/activity/activity_event.dart';
import 'presentation/bloc/assesment/antropometri_cubit.dart';
import 'presentation/bloc/assesment/asam_urat_cubit.dart';
import 'presentation/bloc/assesment/assesment_cubit.dart';
import 'presentation/bloc/assesment/ginjal_cubit.dart';
import 'presentation/bloc/assesment/gula_cubit.dart';
import 'presentation/bloc/assesment/hb1ac_cubit.dart';
import 'presentation/bloc/assesment/kolesterol_cubit.dart';
import 'presentation/bloc/assesment/tensi_cubit.dart';
import 'presentation/bloc/assesment/water_cubit.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/info/article_cubit.dart';
import 'presentation/bloc/info/doctor_cubit.dart';
import 'presentation/bloc/info/video_cubit.dart';
import 'presentation/page/splash_page.dart';
import 'presentation/widget/global_auth_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize error handling first
  GlobalErrorHandler.initialize();

  await ScreenUtil.ensureScreenSize();
  await Injector().initialize();

  // Initialize global connectivity monitoring
  GlobalConnectivityManager().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800), // Set your design size here
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => sl<AuthBloc>()..add(AppStarted()),
          ),
          BlocProvider<AntropometriCubit>(
            create: (_) => sl<AntropometriCubit>(),
          ),
          BlocProvider<ArticleCubit>(create: (_) => sl<ArticleCubit>()),
          BlocProvider<DoctorCubit>(create: (_) => sl<DoctorCubit>()),
          BlocProvider<VideoCubit>(create: (_) => sl<VideoCubit>()),
          BlocProvider<AssesmentCubit>(create: (_) => sl<AssesmentCubit>()),
          BlocProvider<GulaCubit>(create: (_) => sl<GulaCubit>()),
          BlocProvider<Hb1acCubit>(create: (_) => sl<Hb1acCubit>()),
          BlocProvider<KolesterolCubit>(create: (_) => sl<KolesterolCubit>()),
          BlocProvider<WaterCubit>(create: (_) => sl<WaterCubit>()),
          BlocProvider<GinjalCubit>(create: (_) => sl<GinjalCubit>()),
          BlocProvider<AsamUratCubit>(create: (_) => sl<AsamUratCubit>()),
          BlocProvider<TensiCubit>(create: (_) => sl<TensiCubit>()),
          BlocProvider<ActivityBloc>(
            create: (_) => sl<ActivityBloc>()..add(CheckPermissions()),
          ),
        ],
        child: GlobalAuthListener(
          child: MaterialApp(
            title: 'ELAN',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: ColorName.primary,
                titleTextStyle: TextStyle(
                  color: ColorName.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: const IconThemeData(color: ColorName.white),
                toolbarHeight: 60.h,
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorName.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorName.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                floatingLabelStyle: TextStyle(
                  color: ColorName.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
                errorMaxLines: 2,
                isDense: false,
              ),
              textTheme: TextTheme(
                bodyMedium: GoogleFonts.nunito().copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                bodyLarge: GoogleFonts.nunito().copyWith(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
                bodySmall: GoogleFonts.nunito().copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                titleLarge: GoogleFonts.nunito().copyWith(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                titleMedium: GoogleFonts.nunito().copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                titleSmall: GoogleFonts.nunito().copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorName.primary,
                  foregroundColor: ColorName.white,
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: ColorName.primary,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                selectedLabelStyle: TextStyle(color: Colors.white),
                unselectedLabelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            navigatorKey: AppNavigatorImpl.navigatorKey,
            onGenerateRoute: (RouteSettings settings) {
              final argument = settings.arguments;
              return AppRoutes.onGenerateRoutes(argument, settings.name);
            },
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(alwaysUse24HourFormat: true),
              child: ConnectivityAwareWidget(child: child!),
            ),
            home: const SplashPage(),
          ),
        ),
      ),
    );
  }
}
