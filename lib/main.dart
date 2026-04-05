import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Fees.dart';
import 'Schedule.dart';
import 'Notifications.dart';
import 'Homework.dart';
import 'Home.dart';
import 'Profile.dart' as profile;
import 'attendance.dart' as attendance;
import 'Logs.dart';
import 'features/authentication/presentation/screens/Login.dart';
import 'Canteen.dart';
import 'package:mica_school_app/core/injection_container.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const UniSmartBandApp());
}

class UniSmartBandApp extends StatefulWidget {
  const UniSmartBandApp({super.key});

  @override
  State<UniSmartBandApp> createState() => _UniSmartBandAppState();
}

class _UniSmartBandAppState extends State<UniSmartBandApp> {
  bool isDarkMode = false;
  bool isArabic = true;

  void toggleTheme() => setState(() => isDarkMode = !isDarkMode);
  void toggleLanguage() => setState(() => isArabic = !isArabic);

  void _handleLogin(BuildContext context, bool dark) {
    setState(() => isDarkMode = dark);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          isDarkMode: isDarkMode,
          isArabic: isArabic,
          onThemeToggle: toggleTheme,
          onLanguageToggle: toggleLanguage,
          onLogin: _handleLogin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: 
    [
      BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
    ], child:     MaterialApp(
      title: 'Mica School',
      debugShowCheckedModeBanner: false,
      locale: isArabic ? const Locale('ar', 'EG') : const Locale('en', 'US'),
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoginScreen(onLogin: _handleLogin, isArabic: isArabic),
    )); 
    

  }

  ThemeData _buildTheme(Brightness brightness) {
    bool isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
      fontFamily: 'Cairo',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1D4ED8),
        brightness: brightness,
        primary: isDark ? const Color(0xFF6366F1) : const Color(0xFF1D4ED8),
        surface: isDark ? const Color(0xFF1E293B) : Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? const Color(0xFF0F172A) : const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isDarkMode;
  final bool isArabic;
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageToggle;
  final Function(BuildContext, bool) onLogin;

  const MainPage({
    super.key,
    required this.isDarkMode,
    required this.isArabic,
    required this.onThemeToggle,
    required this.onLanguageToggle,
    required this.onLogin,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('saved_profile_image');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() => _profileImage = XFile(imagePath));
    }
  }

  Future<void> _saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_profile_image', path);
  }

  Future<void> _pickNewImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)]),
                ),
                child: const Icon(Icons.camera_alt_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(height: 14),
              Text(
                  widget.isArabic
                      ? "تغيير الصورة الشخصية"
                      : "Change Profile Photo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : const Color(0xFF0D1333))),
              const SizedBox(height: 8),
              Text(
                  widget.isArabic
                      ? "هل تريد اختيار صورة جديدة؟"
                      : "Pick a new photo?",
                  style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 13)),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                    child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(widget.isArabic ? "إلغاء" : "Cancel",
                      style: const TextStyle(color: Colors.grey)),
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() => _profileImage = image);
                        _saveProfileImage(image.path);
                      }
                    },
                    child: Text(widget.isArabic ? "اختر صورة" : "Choose",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )),
              ]),
            ]),
          ),
        );
      },
    );
  }

  List<Widget> _getPages() {
    return [
      HomePage(
        // isArabic: widget.isArabic,
        // profileImage: _profileImage,
        // onNavigate: _handleNavigation,
      ),
      profile.ProfilePage(
          isArabic: widget.isArabic,
          texts: const {},
          profileImage: _profileImage),
      CanteenPage(isArabic: widget.isArabic, isDarkMode: widget.isDarkMode),
      attendance.AttendancePage(
          isArabic: widget.isArabic,
          isDarkMode: widget.isDarkMode,
          texts: const {}),
      // ✅ profileImage بيتمرر هنا عشان الصورة تتزامن مع باقي التطبيق
      LogsPage(
        isArabic: widget.isArabic,
        isDarkMode: widget.isDarkMode,
        profileImage: _profileImage,
      ),
    ];
  }

  void _handleNavigation(String route) {
    switch (route) {
      case 'schedule':
        _pushPage(SchedulePage(isArabic: widget.isArabic));
        break;
      case 'canteen':
        setState(() => _selectedIndex = 2);
        break;
      case 'fees':
        _pushPage(FeesPage(isArabic: widget.isArabic));
        break;
      case 'homework':
        _pushPage(HomeworkPage(isArabic: widget.isArabic));
        break;
      case 'attendance':
        setState(() => _selectedIndex = 3);
        break;
      case 'profile':
        setState(() => _selectedIndex = 1);
        break;
    }
  }

  void _pushPage(Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    final navLabels = widget.isArabic
        ? ['الرئيسية', 'الملف', 'الكانتين', 'الحضور', 'درجتك']
        : ['Home', 'Profile', 'Canteen', 'Attendance', 'Grades'];
    final navIcons = [
      Icons.home_rounded,
      Icons.person_rounded,
      Icons.lunch_dining_rounded,
      Icons.fact_check_rounded,
      Icons.stars_rounded,
    ];

    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF1D4ED8)],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF1D4ED8).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4)),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(children: [
                  Builder(
                      builder: (ctx) => GestureDetector(
                            onTap: () => Scaffold.of(ctx).openDrawer(),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.menu_rounded,
                                  color: Colors.white, size: 20),
                            ),
                          )),
                  const Spacer(),
                  Row(children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Center(
                          child: Text("M",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16))),
                    ),
                    const SizedBox(width: 8),
                    const Text("Mica School",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                  ]),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        _pushPage(NotificationsPage(isArabic: widget.isArabic)),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(alignment: Alignment.center, children: [
                        const Icon(Icons.notifications_none_rounded,
                            color: Colors.white, size: 22),
                        Positioned(
                          top: 7,
                          right: 7,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        drawer: _buildDrawer(context, isDark),
        body: IndexedStack(index: _selectedIndex, children: _getPages()),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131929) : Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4))
            ],
            border: Border(
                top: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.06)
                        : Colors.black.withOpacity(0.06))),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (i) {
                  final isSelected = _selectedIndex == i;
                  const activeColor = Color(0xFF1D4ED8);
                  final inactiveColor =
                      isDark ? Colors.grey[600]! : Colors.grey[400]!;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? activeColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Icon(navIcons[i],
                            color: isSelected ? activeColor : inactiveColor,
                            size: isSelected ? 24 : 22),
                        const SizedBox(height: 3),
                        Text(navLabels[i],
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.normal,
                                color:
                                    isSelected ? activeColor : inactiveColor)),
                      ]),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF1D4ED8),
                  Color(0xFF0284C7)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5), width: 2.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12)
                      ],
                    ),
                    child: ClipOval(
                      child: _profileImage != null
                          ? (kIsWeb
                              ? Image.network(_profileImage!.path,
                                  fit: BoxFit.cover)
                              : Image.file(File(_profileImage!.path),
                                  fit: BoxFit.cover))
                          : Container(
                              color: Colors.white.withOpacity(0.15),
                              child: const Center(
                                  child: Icon(Icons.person_rounded,
                                      size: 36, color: Colors.white)),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text("Mica User",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  const SizedBox(height: 4),
                  Text(
                      widget.isArabic
                          ? "أهلاً بك مجدداً 👋"
                          : "Welcome back 👋",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13)),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _drawerItem(
            Icons.camera_alt_rounded,
            widget.isArabic ? "تغيير الصورة" : "Change Photo",
            const Color(0xFF1D4ED8),
            isDark,
            onTap: () {
              Navigator.pop(context);
              _pickNewImage();
            },
          ),
          _drawerItem(
            Icons.language_rounded,
            widget.isArabic ? "English" : "العربية",
            const Color(0xFF0891B2),
            isDark,
            onTap: () {
              Navigator.pop(context);
              widget.onLanguageToggle();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.04)
                    : Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.isDarkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    color: const Color(0xFF7C3AED),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(widget.isArabic ? "الوضع الليلي" : "Dark Mode",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              isDark ? Colors.white : const Color(0xFF0D1333))),
                ),
                Switch.adaptive(
                    value: widget.isDarkMode,
                    activeColor: const Color(0xFF6366F1),
                    onChanged: (_) => widget.onThemeToggle()),
              ]),
            ),
          ),
          const Spacer(),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LoginScreen(
                          onLogin: widget.onLogin, isArabic: widget.isArabic))),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFFEF4444).withOpacity(0.2)),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.logout_rounded,
                      color: Color(0xFFEF4444), size: 18),
                  const SizedBox(width: 8),
                  Text(widget.isArabic ? "تسجيل الخروج" : "Logout",
                      style: const TextStyle(
                          color: Color(0xFFEF4444),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, Color color, bool isDark,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.04)
                : Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isDark ? Colors.white : const Color(0xFF0D1333))),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 13, color: isDark ? Colors.white30 : Colors.black26),
          ]),
        ),
      ),
    );
  }
}
