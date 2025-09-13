import 'package:flutter/material.dart';

import '../presentation/page/assesment/antropometri_page.dart';
import '../presentation/page/assesment/asam_urat/add_asam_urat_page.dart';
import '../presentation/page/assesment/asam_urat/asam_urat_page.dart';
import '../presentation/page/assesment/assesment_page.dart';
import '../presentation/page/assesment/ginjal/add_ginjal_page.dart';
import '../presentation/page/assesment/ginjal/ginjal_page.dart';
import '../presentation/page/assesment/gula/add_gula_page.dart';
import '../presentation/page/assesment/gula/gula_page.dart';
import '../presentation/page/assesment/hb/add_hb_page.dart';
import '../presentation/page/assesment/hb/hb_page.dart';
import '../presentation/page/assesment/kolesterol/add_kolesterol_page.dart';
import '../presentation/page/assesment/kolesterol/kolesterol_page.dart';
import '../presentation/page/assesment/konsumsi_air/add_konsumsi_air_page.dart';
import '../presentation/page/assesment/konsumsi_air/konsumsi_air_page.dart';
import '../presentation/page/assesment/obat/add_obat_page.dart';
import '../presentation/page/assesment/obat/obat_page.dart';
import '../presentation/page/assesment/tekanan_darah/add_tensi_page.dart';
import '../presentation/page/assesment/tekanan_darah/tensi_page.dart';
import '../presentation/page/auth/login_page.dart';
import '../presentation/page/auth/register_page.dart';
import '../presentation/page/home/activitas/activity_page.dart';
import '../presentation/page/home/activitas/gula_darah_page.dart';
import '../presentation/page/home/activitas/question_page.dart';
import '../presentation/page/home/activitas/recommendation_page.dart';
import '../presentation/page/home/home_page.dart';
import '../presentation/page/home/kalori/diet_page.dart';
import '../presentation/page/home/kalori/kalori_intake_page.dart';
import '../presentation/page/home/kalori/kalori_page.dart';
import '../presentation/page/home/kalori/tujuan_diet_page.dart';
import '../presentation/page/home/info/artikel/artikel_page.dart';
import '../presentation/page/home/info/artikel/detail_artikel_page.dart';
import '../presentation/page/home/info/doctor/doctor_page.dart';
import '../presentation/page/home/info/edukasi/detail_edukasi_page.dart';
import '../presentation/page/home/info/edukasi/edukasi_page.dart';
import '../presentation/page/home/info/video/video_page.dart';
import '../presentation/page/onboarding/onboarding_page.dart';
import '../presentation/page/profile/about_page.dart';
import '../presentation/page/profile/profile_page.dart';
import '../presentation/page/splash_page.dart';
import 'constant.dart';

class AppRoutes {
  static Route onGenerateRoutes(dynamic argument, String? name) {
    late Widget page;

    switch (name) {
      case splashPage:
        page = const SplashPage();
        break;
      case onboardingPage:
        page = const OnboardingPage();
        break;
      case loginPage:
        page = const LoginPage();
        break;
      case registerPage:
        page = const RegisterPage();
        break;

      // Activity Pages
      case questionPage:
        page = const QuestionPage();
        break;
      case gulaDarahPage:
        page = const GulaDarahPage();
        break;
      case recommendationPage:
        page = RecommendationPage(data: argument ?? <String>[]);
        break;
      case activityPage:
        page = const ActivityPage();
        break;

      // Kalori Pages
      case kaloriPage:
        page = const KaloriPage();
        break;
      case tujuanDietPage:
        page = TujuanDietPage(data: argument ?? <String>[]);
        break;
      case kaloriIntakePage:
        page = KaloriIntakePage(data: argument ?? <String>[]);
        break;
      case dietPage:
        page = const DietPage();
        break;

      // Obat Pages
      case obatPage:
        page = const ObatPage();
        break;
      case addObatPage:
        page = const AddObatPage();
        break;

      case antropometriPage:
        page = const AntropometriPage();
        break;

      case homePage:
        page = HomePage(currentPage: argument ?? 0);
        break;

      case profilePage:
        page = const ProfilePage();
        break;
      case aboutPage:
        page = const AboutPage();
        break;

      case articlePage:
        page = const ArtikelPage();
        break;
      case detailArticlePage:
        page = DetailArtikelPage(article: argument);
        break;

      case videoPage:
        page = const VideoPage();
        break;

      case edukasiPage:
        page = const EdukasiPage();
        break;
      case edukasiDetailPage:
        page = DetailEdukasiPage(edukasi: argument);
        break;

      case doctorPage:
        page = const DoctorPage();
        break;

      // Assesment Pages
      case assesmentPage:
        page = const AssesmentPage();
        break;
      case waterPage:
        page = const KonsumsiAirPage();
        break;
      case addWaterPage:
        page = const AddKonsumsiAirPage();
        break;
      case ginjalPage:
        page = const GinjalPage();
        break;
      case addGinjalPage:
        page = const AddGinjalPage();
        break;
      case gulaPage:
        page = const GulaPage();
        break;
      case addGulaPage:
        page = const AddGulaPage();
        break;
      case kolesterolPage:
        page = const KolesterolPage();
        break;
      case addKolesterolPage:
        page = const AddKolesterolPage();
        break;
      case tensiPage:
        page = const TensiPage();
        break;
      case addTensiPage:
        page = const AddTensiPage();
        break;
      case asamUratPage:
        page = const AsamUratPage();
        break;
      case addAsamUratPage:
        page = const AddAsamUratPage();
        break;
      case hbPage:
        page = const HbPage();
        break;
      case addHbPage:
        page = const AddHbPage();
        break;

      default:
        page = const Scaffold(body: Center(child: Text('Page not found')));
    }

    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: argument),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
