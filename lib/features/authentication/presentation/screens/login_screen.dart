import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_state.dart';
import 'package:mica_school_app/features/home/presentation/screens/home_screen.dart';
import 'package:mica_school_app/core/const.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/widgets/login_bg_painter_widget.dart';
import 'package:mica_school_app/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:mica_school_app/main_page.dart';

class LoginScreen extends StatefulWidget {
  // final Function(BuildContext, bool) onLogin;
  final bool isArabic;
  const LoginScreen({Key? key, required this.isArabic}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final Key? feildKey;

  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _bgController;
  late AnimationController _formController;
  late Animation<double> _formFade;
  late Animation<Offset> _formSlide;






  bool _isSigningIn = false;








  bool isDarkMode = false;
  bool isArabic = true;

  void toggleTheme() => setState(() => isDarkMode = !isDarkMode);
  void toggleLanguage() => setState(() => isArabic = !isArabic);

  bool _emailError = false;
  bool _passwordError = false;
  bool _validateErrorMessage = false;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _formFade = CurvedAnimation(parent: _formController, curve: Curves.easeOut);
    _formSlide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _formController, curve: Curves.easeOutCubic),
        );
    _formController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _formController.dispose();
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                    ),
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter your university email",
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                // const SizedBox(height: 20),
                // _buildTextField(
                //   "example@university.edu",
                //   Icons.email_outlined,
                //   false,
                //   isDark,
                // ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text("Reset code sent!"),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xFF10B981),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Send",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty;
  }

  bool _validateId(String id) {
    final regex = RegExp(r'^[a-zA-Z0-9_]{4,20}$');
    return regex.hasMatch(id);
  }

  String? _validateField(String? value, String fieldType) {
    if (fieldType == "email" && !_validateId(value!)) {
      return "Please enter a valid email address.";
    }

    if (fieldType == "password" && !_validatePassword(value!)) {
      return "Please enter a valid password";
    }

    return null;
  }

  void _onTextChanged(String value, String field) {
    setState(() {
      final error = _validateField(value, field);

      switch (field) {
        case "email":
          _emailError = error != null;
          _validateErrorMessage = error != null;
          break;
        case "password":
          _passwordError = error != null;
          break;
      }
    });
  }

  // -------------------------------------------------- Build Method ------------------------------------------------------------------------


//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       body: BlocConsumer<CredentialCubit, CredentialState>(
//         listener: (context, credentialState) {

// // BlocConsumer (
// //hfgjfjfjfgnjgnjgnbjgggfjbg hghhguhgu jhgj
// //)



//           if (credentialState is CredentialLoading) {
//             setState(() {
//               _isSigningIn = true;
//             });
//           }


//           if (credentialState is CredentialSuccess) {
//             BlocProvider.of<AuthCubit>(context).loggedIn();
//             setState(() {
//               _isSigningIn = false;
//             });
//           }



//           if (credentialState is CredentialFailure) {
//             setState(() {
//               _isSigningIn = false;
//             });
//           }
//         },





//         builder: (context, credentailState) {




//           if (credentailState is CredentialSuccess) {

//             return BlocBuilder<AuthCubit, AuthState>(
//               builder: (context, authState) {
//                 if (authState is Authenticated) {
//                   return MainPage(
//                     isDarkMode: isDarkMode,
//                     isArabic: isArabic,
//                     onThemeToggle: toggleTheme,
//                     onLanguageToggle: toggleLanguage,
//                   );
                  
//                 } else {
//                   return _bodyWidget();
//                 }
//               },
//             );
//           }
//           return _bodyWidget();
//         },
//       ),
//     );
//   }


// LoginScreen.dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialLoading) {
          setState(() => _isSigningIn = true);
        }

        if (credentialState is CredentialSuccess) {
          setState(() => _isSigningIn = false);
          // 🔥 تأكدي أن AuthCubit يتحدث بعد نجاح تسجيل الدخول
          context.read<AuthCubit>().loggedIn();
        }

        if (credentialState is CredentialFailure) {
          setState(() => _isSigningIn = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(credentialState.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, credentialState) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            // 🔥 إذا كان المستخدم مصادق عليه، اذهب للـ MainPage
            if (authState is Authenticated) {
              return MainPage(
                isDarkMode: isDarkMode,
                isArabic: isArabic,
                onThemeToggle: toggleTheme,
                onLanguageToggle: toggleLanguage,
              );
            }
            return _bodyWidget();
          },
        );
      },
    ),
  );
}
  _bodyWidget() {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _bgController,
            builder: (_, __) => CustomPaint(
              painter: LoginBgPainter(_bgController.value, isDark),
              size: Size.infinite,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: FadeTransition(
                  opacity: _formFade,
                  child: SlideTransition(
                    position: _formSlide,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 420),
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.04)
                            : Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.white,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? const Color(0xFF4F46E5).withOpacity(0.15)
                                : Colors.black.withOpacity(0.08),
                            blurRadius: 40,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ========================== School Logo ================================
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (isDark
                                              ? const Color(0xFF22D3EE)
                                              : const Color(0xFF4F46E5))
                                          .withOpacity(isDark ? 0.5 : 0.3),
                                  blurRadius: 24,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/user.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // fallback icon if image not found
                                  return const Icon(
                                    Icons.school_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                          // ========================== School Name ==============================
                          const SizedBox(height: 20),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                            ).createShader(bounds),
                            child: const Text(
                              "Mica School",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "School Smart Watch System",
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // =========================== Student ID Field =============================
                          LoginTextField(
                            hint: 'Student ID',
                            icon: Icons.badge_rounded,
                            isPassword: false,
                            isDark: isDark,
                            controller: _studentIdController,
                            onChanged: (value) =>
                                _onTextChanged(value, "email"),
                            validator: (value) =>
                                _validateField(value, "email"),
                          ),
                          const SizedBox(height: 14),
                          // =========================== Password Field =============================
                          LoginTextField(
                            hint: 'Password',
                            icon: Icons.lock_rounded,
                            isPassword: true,
                            isDark: isDark,
                            controller: _passwordController,
                            onChanged: (value) =>
                                _onTextChanged(value, "password"),
                            validator: (value) =>
                                _validateField(value, "password"),
                          ),
                          const SizedBox(height: 28),

                          // =========================== Login Button ==============================
                          Container(
                            width: double.infinity, // full width
                            height: 50, // height of the button
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF4F46E5),
                                  Color(0xFF06B6D4),
                                ], // your gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ElevatedButton(



                       //========================================================       
                              onPressed:
                               _isSigningIn
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _signInUser();
                                      }
                                    },
                       //========================================================       

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Make button transparent
                                shadowColor:
                                    Colors.transparent, // Remove default shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),

                             // issinging in true        ?     fhvfhvfhvf : fbvvjfvjfvbjf 
                              child: _isSigningIn == false
                                  ? Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Signing In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: width * 0.01),
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                         
                          const SizedBox(height: 16),
                          // =========================== Forgot Password Link =============================
                          TextButton(
                            onPressed: _showForgotPasswordDialog,
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: isDark
                                    ? const Color(0xFF22D3EE)
                                    : const Color(0xFF4F46E5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signInUser() async {
    try {
      setState(() {
        _isSigningIn = true;
      });
      await BlocProvider.of<CredentialCubit>(context)
          .signInUser(
            context: context,
            id: _studentIdController.text,
            password: _passwordController.text,
          )
          .then((value) => _clear());
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    }
  }

  _clear() {
    setState(() {
      _studentIdController.clear();
      _passwordController.clear();
      _isSigningIn = false;
    });
  }
}





