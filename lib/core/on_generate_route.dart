// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mica_school_app/core/const.dart';
// import 'package:mica_school_app/features/authentication/presentation/screens/login_screen.dart';

// class OnGenerateRoute {
//   User? user = FirebaseAuth.instance.currentUser;

//   static Route<dynamic>? route(RouteSettings settings) {
//     final args = settings.arguments;

//     switch (settings.name) {
//       case ScreenConst.signInScreen:
//         {
//           return _fadeRoute(LoginScreen());
//         }
//       case ScreenConst.loginScreen:
//         {
//           return _fadeRoute(SignUpScreen());
//         }
//       case ScreenConst.onboardingScreen:
//         {
//           return _fadeRoute(OnboardingScreen());
//         }
//       case ScreenConst.splashScreen:
//         {
//           return _fadeRoute(SplashScreen());
//         }
//       case ScreenConst.verificationScreen:
//         {
//           return _fadeRoute(VerificationScreen());
//         }
//       case ScreenConst.forgotPasswordScreen:
//         {
//           return _fadeRoute(ForgotPasswordScreen());
//         }
//       case ScreenConst.popularApartmentsScreen:
//         {
//           return _fadeRoute(PopularApartmentsScreen());
//         }
//       // case ScreenConst.searchScreen:
//       //   {
//       //     return _fadeRoute(SearchScreen());
//       //   }
//       case ScreenConst.personalInformationScreen:
//         {
//           return _fadeRoute(PersonalInformationScreen());
//         }
//       case ScreenConst.mapTestScreen:
//         {
//           final apartmentId = args as String;
//           return _fadeRoute(MapTestScreen(apartmentId: apartmentId));
//         }
//          case ScreenConst.testScreen2:
//         {
//           return _fadeRoute(TestScreen2());
//         }
//           case ScreenConst.profileScreen:
//         {
//           return _fadeRoute(ProfileScreen());
//         }
//           case ScreenConst.chatRoomScreen:
//         {
//           final args = settings.arguments as ChatRoomArgs;
//           return _fadeRoute(ChatRoomScreen(
//             chatId: args.chatId,
//             currentUserId: args.currentUserId,
//           ));
//         }
//           case ScreenConst.favoritesScreen:
//         {
//           return _fadeRoute(FavoritesScreen());
//         }

//       default:
//         NoScreenFound();
//     }
//   }

//   static PageRouteBuilder _fadeRoute(Widget page) {
//     return PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => page,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(opacity: animation, child: child);
//         });
//   }
// }

// dynamic routeBuilder(Widget child) {
//   return MaterialPageRoute(builder: (ctx) => child);
// }

// class NoScreenFound extends StatelessWidget {
//   const NoScreenFound({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page not found'),
//       ),
//       body: Center(
//         child: Text('Page not found'),
//       ),
//     );
//   }
// }
