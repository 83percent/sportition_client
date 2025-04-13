import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sportition_client/page/center/center_page.dart';
import 'package:sportition_client/page/home/home_page.dart';
import 'package:sportition_client/page/settings/edit_center/edit_center_page.dart';
import 'package:sportition_client/page/settings/edit_profile/edit_profile_description_page.dart';
import 'package:sportition_client/page/settings/edit_profile/edit_profile_gender_page.dart';
import 'package:sportition_client/page/settings/edit_profile/edit_profile_name_page.dart';
import 'package:sportition_client/page/settings/edit_profile/edit_profile_page.dart';
import 'package:sportition_client/page/settings/setting_page.dart';
import 'package:sportition_client/page/init/init_page.dart';
import 'package:sportition_client/page/join/join_page.dart';
import 'package:sportition_client/page/login/login_page.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mainRedColor,
          background: AppColors.backgroundColor,
        ),
        useMaterial3: true,
      ),
      home: const InitPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/join': (context) => const JoinPage(),
        '/home': (context) => const HomePage(),
        '/setting': (context) => const SettingPage(),
        /* Setting Profile  */
        '/setting/edit/profile': (context) => const EditProfilePage(),
        '/setting/edit/profile/name': (context) => const EditProfileNamePage(),
        '/setting/edit/profile/gender': (context) =>
            const EditProfileGenderPage(),
        '/setting/edit/profile/description': (context) =>
            const EditProfileDescriptionPage(),

        /* Setting Center */
        '/setting/edit/center': (context) => EditCenterPage(),

        /* Center */
        '/center': (context) => const CenterPage(),
      },
    );
  }
}
