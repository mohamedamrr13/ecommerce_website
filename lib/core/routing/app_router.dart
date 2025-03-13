import 'package:ecommerce_website/features/authentication/logic/google_cubit/google_cubit.dart';
import 'package:ecommerce_website/features/authentication/logic/login_cubit/login_cubit.dart';
import 'package:ecommerce_website/features/authentication/logic/register_cubit/register_cubit.dart';
import 'package:ecommerce_website/features/authentication/presentation/login_screen.dart';
import 'package:ecommerce_website/features/authentication/presentation/register_screen.dart';
import 'package:ecommerce_website/features/cart/presentation/cart_screen.dart';
import 'package:ecommerce_website/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const signUpScreen = "/signUp";
  static const loginScreen = "/login";
  static const forgetPassword = "/forgetPassword";
  static const changePassword = "/changePassword";
  static const verifyOtpCode = "/verifyOtpCode";
  static const homeScreen = "/homeScreen";
  static const cartPage = "/cartPage";
  static GoRouter router = GoRouter(
    initialLocation: cartPage,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: homeScreen,
        name: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: loginScreen,
        name: loginScreen,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => GoogleCubit())
        ], child: const LoginScreen()),
      ),
      GoRoute(
        path: signUpScreen,
        name: signUpScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => RegisterCubit()),
            BlocProvider(create: (context) => GoogleCubit())
          ],
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: cartPage,
        name: cartPage,
        builder: (context, state) => const CartScreen(),
      ),
      // GoRoute(
      //   path: forgetPassword,
      //   name: forgetPassword,
      //   builder: (context, state) => const ForgetPasswordScreen(),
      // ),
      // GoRoute(
      //   path: changePassword,
      //   name: changePassword,
      //   builder: (context, state) => const ChangepasswordScreen(),
      // ),
      // GoRoute(
      //   path: verifyOtpCode,
      //   name: verifyOtpCode,
      //   builder: (context, state) => const VerifyOtpCodeScreen(),
      // ),
    ],
  );

  // Slide transition
  static Widget _slideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0); // Slide from right
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  // Fade transition
  static Widget _fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
