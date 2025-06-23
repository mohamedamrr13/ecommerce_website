import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: _getDesignSize(context),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: SafeArea(
            child: MaterialApp.router(
              title: "Exclusive",
              routerConfig: AppRouter.router,
              theme: ThemeData(fontFamily: 'Poppins'),
              debugShowCheckedModeBanner: false,
            ),
          )),
    );
  }
}

Size _getDesignSize(BuildContext context) {
  final MediaQueryData mediaQuery = MediaQuery.of(context);
  final double shortestSide = mediaQuery.size.shortestSide;

  if (shortestSide < 600) {
    // Mobile (Phones)
    return const Size(
        360, 600); 
  } else if (shortestSide < 1200) {
    // Tablet
    return const Size(768, 1024); 
  } else {
    // PC (Desktop/Large screens)
    return const Size(1440, 1024);
  }
}
