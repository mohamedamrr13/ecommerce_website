import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:ecommerce_website/features/home/presentation/widgets/home_screen_body.dart';
import 'package:ecommerce_website/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isSearchExpanded = false; // NEW

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(93),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Winter Sale For All Watches And Express Delivery - OFF 50%!',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Text(
                    'Exclusive',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  const Spacer(),
                  // const SizedBox(width: 60),
                  // IconButton(
                  //   icon: const Icon(Icons.favorite_border),
                  //   onPressed: () {},
                  // ),
                  if (!isSearchExpanded) ...[
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        GoRouter.of(context).go(AppRouter.cartPage);
                      },
                    ),
                    SizedBox(width: 5.w),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).go(AppRouter.loginScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 8.sp),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                  CustomSearchBar(
                    onChanged: (p0) {},
                    onExpandChanged: (expanded) {
                      setState(() => isSearchExpanded = expanded);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const HomeScreenBody(),
    );
  }
}
