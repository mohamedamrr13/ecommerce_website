import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Card(
        color: Colors.grey[100],
        elevation: 0,
        child: InkWell(
          onHover: (value) {
            if (value == true) {
              setState(() {
                isHovered = true;
              });
            } else {
              setState(() {
                isHovered = false;
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 48, color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '-40%',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(Icons.favorite_border, size: 16),
                    ),
                  ),
                  isHovered
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            height: 40,
                            child: const Center(
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                      : const SizedBox()
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Item X',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '\$80.00',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$120.00',
                    style: TextStyle(
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Row(
              //   children: [
              //     const Icon(Icons.star, color: Colors.amber, size: 16),
              //     const Text(
              //       '4.8',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       ' (88)',
              //       style: TextStyle(color: Colors.grey[600], fontSize: 12),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
