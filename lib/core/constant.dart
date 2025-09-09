import '../gen/assets.gen.dart';

const String baseURL = 'https://elan.cmutiah.com/api';
const String tokenKey = 'auth_token';
const String antropometriKey = 'antropometri_data';
const String activityKey = 'activity_data';
const String userIDKey = 'user_id';
const String typeDiabetesKey = 'type_diabetes';

// RouteName Config
const String splashPage = '/';
const String loginPage = '/login';
const String registerPage = '/register';
const String onboardingPage = '/onboarding';
const String questionPage = '/question';
const String gulaDarahPage = '/check-gula-darah';
const String recommendationPage = '/recommendation';
const String activityPage = '/activity';
const String kaloriPage = '/kalori';
const String tujuanDietPage = '/tujuan-diet';
const String kaloriIntakePage = '/kalori-intake';
const String dietPage = '/diet';
const String homePage = '/home';
const String profilePage = '/profile';

const String aboutPage = '/about';
const String articlePage = '/articles';
const String detailArticlePage = '/articles/detail';
const String edukasiPage = '/edukasi';
const String edukasiDetailPage = '/edukasi/detail';
const String doctorPage = '/doctors';
const String nutrisiPage = '/nutrisi';
const String addNutrisiPage = '/nutrisi/add';
const String obatPage = '/obat';
const String addObatPage = '/obat/add';
const String videoPage = '/video';

// Assesment Page
const String antropometriPage = '/antropometri';
const String assesmentPage = '/assesment';
const String waterPage = '/water';
const String addWaterPage = '/water/add';
const String gulaPage = '/blood-sugar';
const String addGulaPage = '/blood-sugar/add';
const String aktifitasPage = '/activity';
const String addAktifitasPage = '/activity/add';
const String hbPage = '/hb1ac';
const String addHbPage = '/hb1ac/add';
const String tensiPage = '/blood-pressure';
const String addTensiPage = '/blood-pressure/add';
const String ginjalPage = '/kidney';
const String addGinjalPage = '/kidney/add';
const String kolesterolPage = '/kolesterol';
const String addKolesterolPage = '/kolesterol/add';
const String asamUratPage = '/gout';
const String addAsamUratPage = '/gout/add';
// =====================================

final List<Map<String, dynamic>> edukasi = [
  {
    'title': 'Apa yang Dilakukan Agar Selamat dan Aman Saat Banjir',
    'image': [Assets.images.apaYangDilakukanAgarSelamatDanAmanSaatBanjir.path],
  },
  {
    'title': 'Apa yang Dilakukan Agar Selamat dan Aman Saat Kebakaran',
    'image': [
      Assets.images.apaYangDilakukanAgarSelamatDanAmanSaatKebakaran.path,
    ],
  },
  {
    'title': 'Apa Saja yang Harus Dibawa Dalam Tas Siaga Bencana',
    'image': [Assets.images.apaSajaYangHarusDibawaDalamTasSiagaBencana.path],
  },
  {
    'title': 'Edukasi Bencana Untuk Lansia',
    'image': [
      Assets.images.edukasiBencanaUntukLansia1.path,
      Assets.images.edukasiBencanaUntukLansia2.path,
      Assets.images.edukasiBencanaUntukLansia3.path,
      Assets.images.edukasiBencanaUntukLansia4.path,
      Assets.images.edukasiBencanaUntukLansia5.path,
      Assets.images.edukasiBencanaUntukLansia6.path,
    ],
  },
];

final List<String> questions = [
  'Apakah Anda mengalami gejala seperti sering haus, sering buang air kecil?',
  'Apakah Anda sering merasa lemas, lapar berlebihan, atau berat badan turun dratis?',
  'Apakah Anda memiliki riwayat diabetes di keluarga (ayah/ibu/saudara)?',
  'Apakah Anda memiliki tekanan darah tinggi atau kolesterol tinggi?',
  'Apakah Anda berusia diatas 40 tahun dan jarang bergerak?',
];

final Map<String, List<String>> recommendations = {
  'normal': [
    'Pertahankan pola makan sehat (sayur, buah, dan hindari konsumsi gula hingga minyak berlebih).',
    'Lakukan aktivitas fisik teratur minimal 30 menit setiap hari.',
    'Pemeriksaan Gula Darah ulang tiap 3 bulan.',
    'Pantau Tekanan Darah dan Berat Badan.',
  ],
  'diabetes': [
    'Konsultasikan segera dengan dokter untuk rencana pengobatan.',
    'Mulai diet DM (rendah gula dan karbohidrat, makanan tinggi serat seperti sayur dan buah yang tidak terlalu manis, makanan rendah garam/natrium, hindari makanan yang digoreng/dibakar, dan makanan siap saji/diawetkan).',
    'Lakukan aktivitas fisik ringan (jalan kaki dan senam ringan).',
    'Monitor gula darah setiap hari atau minimal 3 kali seminggu.',
    'Istirahat yang cukup yaitu 6 s.d 8 jam per hari.',
    'Lakukan pemeriksaan kaki dan mata secara berkala.',
    'Ikuti edukasi DM secara berkala bersama sudah perawat/dokter/tenaga kesehatan.',
  ],
};

final List<String> obatType = [
  '',
  'Tablet',
  'Kaplet',
  'Kapsul',
  'IU',
  'mL',
  'Sendok',
  'Tetes',
  'Olesan',
  'Sachet',
  'Sachet',
];

final List<String> activityOptions = [
  '-',
  'Berjalan Kaki',
  'Jogging',
  'Lari',
  'Berenang',
  'Bersepeda',
  'Senam',
  'Angkat Beban Ringan - Sedang',
  'Angkat Beban Berat',
  'Voli',
  'Badminton',
  'Sepak Bola/Futsal',
  'Tenis',
  'Tenis Meja',
];

const int typeNormal = 0;
const int typeDM = 1;
const int typePreDM = 2;

final List<String> karboOptions = [
  '-',
  'Nasi Merah 150 gr (1 mangkok kecil) (200 kkal)',
  'Nasi Putih 150 gr (1 mangkok kecil) (250 kkal)',
  'Nasi Gurih/Liwet 150 gr (1 mangkok kecil) (290 kkal)',
  'Ubi kukus 1 potong 150 gr (115 kkal)',
  'Roti gandum 1 lembar (75 kkal)',
  'Pisang kukus 1 buah ukuran sedang (100 kkal)',
  'Singkong rebus 100 gr (190 kkal)',
  'Jagung rebus 100 gr (96 kkal)',
  'Kentang rebus 100 gr (87 kkal)',
  'Oatmeal 1 mangkuk kecil (150 kkal)',
  'Biskuit 1 keping (35 kkal)',
];

final List<String> proteinOptions = [
  '-',
  'Telur rebus 1 butir (90 kkal)',
  'Ikan 1 potong 60 gr (120 kkal)',
  'Tempe 1 potong ukuran kecil (90 kkal)',
  'Tahu 1 potong ukuran kecil (35 kkal)',
  'Daging Ayam 1 potong 100 gr (170 kkal)',
  'Daging Kambing 1 potong 100 gr (109 kkal)',
  'Daging Sapi 1 potong 100 gr (250 kkal)',
  'Udang 1 buah (9 kkal)',
  'Kacang rebus 100 gr (155 kkal)',
];

final List<String> seratOptions = [
  '-',
  'Sayur bayam 1 mangkuk (40 kkal)',
  'Daun singkong 100 gr (50 kkal)',
  'Daun pepaya 100 gr (50 kkal)',
  'Nangka muda 100 gr (50 kkal)',
  'Daun talas 100 gr (50 kkal)',
  'Sawi 100 gr (25 kkal)',
  'Kangkung 100 gr (25 kkal)',
  'Tauge 100 gr (25 kkal)',
  'Kacang panjang 100 gr (25 kkal)',
  'Buncis 100 gr (25 kkal)',
  'Daun katuk 100 gr (25 kkal)',
  'Timun 100 gr (20 kkal)',
  'Selada 100 gr (20 kkal)',
  'Tomat 100 gr (20 kkal)',
  'Apel 100 gr (52 kkal)',
  'Pir 100 gr (57 kkal)',
  'Semangka 100 gr (30 kkal)',
  'Melon 100 gr (34 kkal)',
  'Jambu biji 100 gr (68 kkal)',
  'Buah naga 100 gr (50 kkal)',
  'Pepaya 100 gr (43 kkal)',
  'Stroberi 100 gr (32 kkal)',
  'Anggur 100 gr (67 kkal)',
  'Salak 100 gr (82 kkal)',
  'Duku 100 gr (67 kkal)',
  'Belimbing 100 gr (31 kkal)',
  'Kedondong 100 gr (40 kkal)',
  'Bengkoang 100 gr (38 kkal)',
  'Sawo 100 gr (83 kkal)',
  'Jambu air 100 gr (46 kkal)',
  'Kelengkeng 100 gr (60 kkal)',
];

const normalWeight = 'Normal';
const underWeight = 'Kurus';
const overWeight = 'Obesitas';

final Map<String, Map<String, List<String>>> tujuanDiet = {
  'DM': {
    underWeight: [
      'Meningkatkan berat badan secara sehat dan bertahap',
      'Menjaga kestabilan gula darah',
      'Memenuhi kebutuhan energi dan nutrisi',
      'Menghindari risiko komplikasi DM akibat defisiensi gizi',
    ],
    overWeight: [
      'Mengurangi berat badan secara bertahap (0.5 - 1 kg/minggu)',
      'Menjaga kestabilan gula darah',
      'Menjaga massa otot dan metabolisme',
      'Menghindari risiko komplikasi DM akibat defisiensi gizi',
    ],
  },
  'Normal': {
    underWeight: [
      'Meningkatkan berat badan secara sehat dan bertahap',
      'Menjaga kestabilan gula darah',
      'Memenuhi kebutuhan energi dan nutrisi',
      'Menghindari terjadinya DM',
    ],
    normalWeight: [
      'Mempertahankan berat badan ideal',
      'Menjaga kestabilan gula darah',
      'Memenuhi kebutuhan energi dan nutrisi',
      'Menghindari terjadinya DM',
    ],
    overWeight: [
      'Mengurangi berat badan secara bertahap (0.5-1 kg/minggu)',
      'Menjaga kestabilan gula darah',
      'Memenuhi kebutuhan energi dan nutrisi',
      'Menghindari terjadinya DM',
    ],
  },
};

final Map<String, List<String>> dataKaloriIntake = {
  'DM': [
    'Karbohidrat 50 - 60%',
    'Lemak sehat 20 - 25%',
    'Protein 15 - 20%',
    'Serat 25 - 30 g/hari',
  ],
  'Normal': [
    'Karbohidrat 45 - 65%',
    'Lemak sehat 20 - 30%',
    'Protein 20 - 25%',
    'Serat 25 - 30 g/hari',
  ],
};
