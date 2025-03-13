import 'package:flutter/material.dart';

class FlashSalesHeader extends StatelessWidget {
  const FlashSalesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              color: Colors.red,
            ),
            const SizedBox(width: 8),
            const Text(
              "Our Products",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              'Premium Classic Watches',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
