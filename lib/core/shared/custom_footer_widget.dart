import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomFooterWidget extends StatefulWidget {
  const CustomFooterWidget({super.key});

  @override
  State<CustomFooterWidget> createState() => _CustomFooterWidgetState();
}

class _CustomFooterWidgetState extends State<CustomFooterWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.w : 24.w,
        vertical: isMobile ? 30.h : 80.h,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      'Exclusive',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height: 16.h), // Add spacing between text and icons
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Align icons to the left
                      children: [
                        Icon(Icons.facebook, color: Colors.white, size: 24.sp),
                        SizedBox(width: 16.w),
                        Icon(Iconsax.instagram,
                            color: Colors.white, size: 24.sp),
                        SizedBox(width: 16.w),
                        Icon(Icons.tiktok, color: Colors.white, size: 24.sp),
                      ],
                    )
                  ],
                )
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildFooterSection('Exclusive', []),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Align icons to the left
                        children: [
                          Icon(Icons.facebook,
                              color: Colors.white, size: 12.sp),
                          SizedBox(width: 16.w), // Add spacing between icons
                          Icon(Iconsax.instagram,
                              color: Colors.white, size: 12.sp),
                          SizedBox(width: 16.w),
                          Icon(Icons.tiktok, color: Colors.white, size: 12.sp),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: _buildFooterSection(
                    'Support',
                    [
                      '111 Bijoy sarani, Dhaka,\nDH 1515, Bangladesh.',
                      'exclusive@gmail.com',
                      '+88015-88888-9999',
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: _buildFooterSection(
                    'Account',
                    [
                      'My Account',
                      'Login / Register',
                      'Cart',
                      'Wishlist',
                      'Shop',
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: _buildFooterSection(
                    'Quick Link',
                    [
                      'Privacy Policy',
                      'Terms Of Use',
                      'FAQ',
                      'Contact',
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildFooterSection(String title, List<String> items) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 20.sp : 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24.h),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: isMobile ? 14.sp : 8.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
