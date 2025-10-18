import 'package:flutter/material.dart';

class CustomAuthAppbar extends StatelessWidget {
  const CustomAuthAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 16,
            vertical: 8,
          ),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Winter Sale For All Perfumes And Express Delivery - OFF 50%!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 12 : 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Knouz',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 20 : 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
