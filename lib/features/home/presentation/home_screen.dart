import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:ecommerce_website/features/home/presentation/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
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
                  const Text(
                    'Exclusive',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 60,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Home',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Contact',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'About',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).go(AppRouter.loginScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
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
