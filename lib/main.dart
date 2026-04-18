import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_cubit.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_scan_cubit/attendance_scan_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:mica_school_app/features/home/presentation/cubit/schedule_cubit/schedule_cubit.dart';
import 'package:mica_school_app/features/homework/presentation/cubit/homework_cubit.dart';
import 'package:mica_school_app/main_page.dart';

import 'package:mica_school_app/core/injection_container.dart' as di;

//------------------------------------------------------------ MAIN FUNCTION ------------------------------------------------------------------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}
//------------------------------------------------------- MyApp Widget-------------------------------------------------------------------------------

class MyApp extends StatefulWidget {

  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  bool isArabic = true;
  String? hardwareUid; // Add this line to store the hardware UID
  // Example major ID, replace with actual value as needed

  void toggleTheme() => setState(() => isDarkMode = !isDarkMode);
  void toggleLanguage() => setState(() => isArabic = !isArabic);

  // void _handleLogin(BuildContext context, bool dark) {
  //   setState(() => isDarkMode = dark);
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MainPage(
  //         isDarkMode: isDarkMode,
  //         isArabic: isArabic,
  //         onThemeToggle: toggleTheme,
  //         onLanguageToggle: toggleLanguage,
  //         onLogin: _handleLogin,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<ScheduleCubit>()),
        BlocProvider(create: (_) => di.sl<AttendanceScanCubit>()),
        BlocProvider(create: (_) => di.sl<AttendanceLogsCubit>()),
        BlocProvider(create: (_) => di.sl<HomeworkCubit>()),
        BlocProvider(
          create: (_) =>
              di.sl<GetSingleUserCubit>()
                ..getSingleUser(uid: FirebaseAuth.instance.currentUser!.uid),
        ),
      ],
      child: MaterialApp(
        title: 'Mica School',
        debugShowCheckedModeBanner: false,
        locale: isArabic ? const Locale('ar', 'EG') : const Locale('en', 'US'),
        theme: _buildTheme(Brightness.light),
        darkTheme: _buildTheme(Brightness.dark),
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return
              //MainScreen();
              MainPage(
             
                isDarkMode: isDarkMode,
                isArabic: isArabic,
                onThemeToggle: toggleTheme,
                onLanguageToggle: toggleLanguage,
              );
            } else {
              return LoginScreen(
                // onLogin: _handleLogin,
                isArabic: isArabic,
              );
            }
          },
        ),
      ),
    );
  }

// -------------------------------------------------- Theme Function ------------------------------------------------------------------------
  ThemeData _buildTheme(Brightness brightness) {
    bool isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF0F4FF),
      fontFamily: 'Cairo',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1D4ED8),
        brightness: brightness,
        primary: isDark ? const Color(0xFF6366F1) : const Color(0xFF1D4ED8),
        surface: isDark ? const Color(0xFF1E293B) : Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? const Color(0xFF0F172A)
            : const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}

         // TextButton(
                          //   onPressed: () async {
                          //     await FirebaseAuth.instance.signOut();
                          //   },
                          //   child: Text(
                          //     "Sign Out",
                          //     style: TextStyle(
                          //       fontSize: width * 0.04,
                          //       color: const Color.fromARGB(255, 131, 36, 28),
                          //     ),
                          //   ),
                          // ),