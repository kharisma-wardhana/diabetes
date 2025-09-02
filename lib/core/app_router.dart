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
  static MaterialPageRoute onGenerateRoutes(dynamic argument, String? name) {
    switch (name) {
      case splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case onboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      // Activity Pages
      case questionPage:
        return MaterialPageRoute(builder: (_) => const QuestionPage());
      case gulaDarahPage:
        return MaterialPageRoute(builder: (_) => const GulaDarahPage());
      case recommendationPage:
        return MaterialPageRoute(
          builder: (context) {
            final args = argument ?? <String>[];
            return RecommendationPage(data: args);
          },
        );
      case activityPage:
        return MaterialPageRoute(builder: (_) => const ActivityPage());
      //============================================================
      // Kalori Pages
      case kaloriPage:
        return MaterialPageRoute(builder: (_) => const KaloriPage());
      case tujuanDietPage:
        return MaterialPageRoute(
          builder: (context) {
            final args = argument ?? <String>[];
            return TujuanDietPage(data: args);
          },
        );
      case kaloriIntakePage:
        return MaterialPageRoute(
          builder: (context) {
            final args = argument ?? <String>[];
            return KaloriIntakePage(data: args);
          },
        );
      case dietPage:
        return MaterialPageRoute(builder: (_) => const DietPage());
      //============================================================
      // Obat Pages
      case obatPage:
        return MaterialPageRoute(builder: (_) => const ObatPage());
      case addObatPage:
        return MaterialPageRoute(builder: (_) => const AddObatPage());
      //============================================================
      case antropometriPage:
        return MaterialPageRoute(builder: (_) => const AntropometriPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case aboutPage:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      // Info Pages
      case articlePage:
        return MaterialPageRoute(builder: (_) => const ArtikelPage());
      case detailArticlePage:
        return MaterialPageRoute(
          builder: (_) => DetailArtikelPage(article: argument),
        );
      case videoPage:
        return MaterialPageRoute(builder: (_) => const VideoPage());
      case edukasiPage:
        return MaterialPageRoute(builder: (_) => const EdukasiPage());
      case edukasiDetailPage:
        return MaterialPageRoute(
          builder: (_) => DetailEdukasiPage(edukasi: argument),
        );
      case doctorPage:
        return MaterialPageRoute(builder: (_) => const DoctorPage());
      //============================================================
      // Assesment Pages
      case assesmentPage:
        return MaterialPageRoute(builder: (_) => const AssesmentPage());
      case waterPage:
        return MaterialPageRoute(builder: (_) => const KonsumsiAirPage());
      case addWaterPage:
        return MaterialPageRoute(builder: (_) => const AddKonsumsiAirPage());
      case ginjalPage:
        return MaterialPageRoute(builder: (_) => const GinjalPage());
      case addGinjalPage:
        return MaterialPageRoute(builder: (_) => const AddGinjalPage());
      case gulaPage:
        return MaterialPageRoute(builder: (_) => const GulaPage());
      case addGulaPage:
        return MaterialPageRoute(builder: (_) => const AddGulaPage());
      case kolesterolPage:
        return MaterialPageRoute(builder: (_) => const KolesterolPage());
      case addKolesterolPage:
        return MaterialPageRoute(builder: (_) => const AddKolesterolPage());
      case tensiPage:
        return MaterialPageRoute(builder: (_) => const TensiPage());
      case addTensiPage:
        return MaterialPageRoute(builder: (_) => const AddTensiPage());
      case asamUratPage:
        return MaterialPageRoute(builder: (_) => const AsamUratPage());
      case addAsamUratPage:
        return MaterialPageRoute(builder: (_) => const AddAsamUratPage());
      case hbPage:
        return MaterialPageRoute(builder: (_) => const HbPage());
      case addHbPage:
        return MaterialPageRoute(builder: (_) => const AddHbPage());
      //============================================================
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
