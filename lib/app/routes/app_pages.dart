import 'package:get/get.dart';

import '../modules/ajukan_peminjaman/bindings/ajukan_peminjaman_binding.dart';
import '../modules/ajukan_peminjaman/views/ajukan_peminjaman_view.dart';
import '../modules/ajukan_pengembalian/bindings/ajukan_pengembalian_binding.dart';
import '../modules/ajukan_pengembalian/views/ajukan_pengembalian_view.dart';
import '../modules/camera_location/bindings/camera_location_binding.dart';
import '../modules/camera_location/views/camera_location_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/contact_admin/bindings/contact_admin_binding.dart';
import '../modules/contact_admin/views/contact_admin_view.dart';
import '../modules/detail_inventaris/bindings/detail_inventaris_binding.dart';
import '../modules/detail_inventaris/views/detail_inventaris_view.dart';
import '../modules/forget_pass/bindings/forget_pass_binding.dart';
import '../modules/forget_pass/views/forget_pass_view.dart';
import '../modules/form_penilaian/bindings/form_penilaian_binding.dart';
import '../modules/form_penilaian/views/form_penilaian_view.dart';
import '../modules/history_penilaian/bindings/history_penilaian_binding.dart';
import '../modules/history_penilaian/views/history_penilaian_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventaris/bindings/inventaris_binding.dart';
import '../modules/inventaris/views/inventaris_view.dart';
import '../modules/new_pass/bindings/new_pass_binding.dart';
import '../modules/new_pass/views/new_pass_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onBoarding/bindings/on_boarding_binding.dart';
import '../modules/onBoarding/views/on_boarding_view.dart';
import '../modules/penilaian/bindings/penilaian_binding.dart';
import '../modules/penilaian/views/penilaian_view.dart';
import '../modules/presence_coach/bindings/presence_coach_binding.dart';
import '../modules/presence_coach/views/presence_coach_view.dart';
import '../modules/presence_student/bindings/presence_student_binding.dart';
import '../modules/presence_student/views/presence_student_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reschedule/bindings/reschedule_binding.dart';
import '../modules/reschedule/views/reschedule_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/schedule_detail/bindings/schedule_detail_binding.dart';
import '../modules/schedule_detail/views/schedule_detail_view.dart';
import '../modules/signIn/bindings/sign_in_binding.dart';
import '../modules/signIn/views/sign_in_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      bindings: [
        HomeBinding(),
        ScheduleBinding(),
        InventarisBinding(),
        ProfileBinding(),
        PenilaianBinding(),
        NotificationBinding(),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.INVENTARIS,
      page: () => const InventarisView(),
      binding: InventarisBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PENILAIAN,
      page: () => const PenilaianView(),
      binding: PenilaianBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_ADMIN,
      page: () => const ContactAdminView(),
      binding: ContactAdminBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASS,
      page: () => ForgetPassView(),
      binding: ForgetPassBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASS,
      page: () => const NewPassView(),
      binding: NewPassBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE_DETAIL,
      page: () => ScheduleDetailView(),
      binding: ScheduleDetailBinding(),
    ),
    GetPage(
      name: _Paths.PRESENCE_COACH,
      page: () => const PresenceCoachView(),
      binding: PresenceCoachBinding(),
    ),
    GetPage(
      name: _Paths.PRESENCE_STUDENT,
      page: () => const PresenceStudentView(),
      binding: PresenceStudentBinding(),
    ),
    GetPage(
      name: _Paths.RESCHEDULE,
      page: () => RescheduleView(),
      binding: RescheduleBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_LOCATION,
      page: () => const CameraLocationView(),
      binding: CameraLocationBinding(),
    ),
    GetPage(
      name: _Paths.FORM_PENILAIAN,
      page: () => const FormPenilaianView(),
      binding: FormPenilaianBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_PENILAIAN,
      page: () => const HistoryPenilaianView(),
      binding: HistoryPenilaianBinding(),
    ),
    GetPage(
      name: _Paths.AJUKAN_PEMINJAMAN,
      page: () => const AjukanPeminjamanView(),
      binding: AjukanPeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.AJUKAN_PENGEMBALIAN,
      page: () => const AjukanPengembalianView(),
      binding: AjukanPengembalianBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_INVENTARIS,
      page: () => const DetailInventarisView(),
      binding: DetailInventarisBinding(),
    ),
  ];
}
