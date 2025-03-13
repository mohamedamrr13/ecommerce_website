import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:ecommerce_website/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_website/shared/custom_footer_widget.dart';
import 'package:ecommerce_website/utils/appconstraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartModel> cartItems = [
    CartModel(
        name: "Controller",
        price: 70,
        image: "assets/images/Gamepad-Cart-Small.png"),
    CartModel(
        name: "Controller",
        price: 70,
        image: "assets/images/Gamepad-Cart-Small.png"),
    CartModel(
        name: "Controller",
        price: 70,
        image: "assets/images/Gamepad-Cart-Small.png"),
    CartModel(
        name: "Controller",
        price: 70,
        image: "assets/images/Gamepad-Cart-Small.png")
  ];

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Breadcrumb
                  const Row(
                    children: [
                      Text('Home'),
                      Text(' / '),
                      Text('Cart',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                      height: AppConstraints.isMobile(context) ? 30.h : 60.h),

                  // Cart items table
                  CartItemsSection(),

                  SizedBox(
                      height: AppConstraints.isMobile(context) ? 0.h : 60.h),

                  cartItems.isNotEmpty
                      ? _buildCartTotals()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Add Items To Cart",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffDB4444)),
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                      },
                                      child: const Text(
                                        "Back To Shop",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            cartItems.isEmpty
                ? AppConstraints.isMobile(context)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.width * 0.3.w,
                      )
                    : const SizedBox()
                : const SizedBox(),
            const CustomFooterWidget()
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CartItemsSection() {
    return AppConstraints.isMobile(context)
        ? Column(
            children: cartItems
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Card(
                        color: Colors.grey[100],
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    item.image,
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text('\$${item.price}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 12,
                                        ),
                                        onPressed: () =>
                                            _updateQuantity(item, false),
                                      ),
                                      Text('${item.quantity}'),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          size: 12,
                                        ),
                                        onPressed: () =>
                                            _updateQuantity(item, true),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$${item.price * item.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade200),
              columnWidths: {
                0: const FlexColumnWidth(3), // Product
                1: const FlexColumnWidth(1), // Price
                2: AppConstraints.screenWidth(context) <= 900
                    ? const FlexColumnWidth(2)
                    : const FlexColumnWidth(1), // Quantity
                3: const FlexColumnWidth(1), // Subtotal
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Colors.white),
                  children: [
                    _buildTableHeader('Product'),
                    _buildTableHeader('Price'),
                    _buildTableHeader('Quantity'),
                    _buildTableHeader('Subtotal'),
                  ],
                ),
                ...cartItems.map((item) => TableRow(
                      children: [
                        _buildProductCell(item),
                        _buildPriceCell(item.price),
                        _buildQuantityCell(item),
                        _buildSubtotalCell(item.price * item.quantity),
                      ],
                    )),
              ],
            ),
          );
  }

  Widget _buildCartTotals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300.w,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Colors.black)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Cart Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTotalRow('Subtotal:', '\$$subtotal'),
                  _buildTotalRow('Shipping:', '60'),
                  const Divider(),
                  _buildTotalRow('Total:', '\$${subtotal + 60}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Proceed to checkout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProductCell(CartModel item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            item.image,
            width: 60,
            height: 60,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCell(double price) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('\$$price'),
    );
  }

  Widget _buildQuantityCell(CartModel item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              size: 16,
            ),
            onPressed: () => _updateQuantity(item, false),
          ),
          Text('${item.quantity}'),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 16,
            ),
            onPressed: () => _updateQuantity(item, true),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtotalCell(double subtotal) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('\$$subtotal'),
    );
  }

  void _updateQuantity(CartModel item, bool increase) {
    setState(() {
      if (increase) {
        item.quantity++;
      } else if (item.quantity > 1) {
        item.quantity--;
      }
    });
  }
}
