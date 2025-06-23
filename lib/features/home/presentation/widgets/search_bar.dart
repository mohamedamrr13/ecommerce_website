import 'package:ecommerce_website/utils/appconstraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final ValueChanged<bool>? onExpandChanged;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.onExpandChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool showSearchField = false;
  final TextEditingController _controller = TextEditingController();

  static const Color textColor = Colors.black;
  static const Color buttonColor = Colors.white;

  void _toggleSearch(bool expand) {
    setState(() => showSearchField = expand);
    widget.onExpandChanged?.call(expand);
  }

  @override
  Widget build(BuildContext context) {
    // More responsive width calculation based on available space
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate expanded width as a percentage of screen width
    double expandedWidth;
    if (AppConstraints.isMobile(context)) {
      expandedWidth = screenWidth * 0.4; // 60% of screen width for mobile
    } else if (AppConstraints.isTablet(context)) {
      expandedWidth = screenWidth * 0.3; // 40% of screen width for tablet
    } else {
      expandedWidth = 220.w; // Original size for desktop
    }

    // Ensure minimum width
    expandedWidth = expandedWidth.clamp(100.0, 300.0);

    // Collapsible button width - keeping it proportional
    double collapsedWidth = 37;

    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: showSearchField ? expandedWidth : collapsedWidth,
        height: 37,
        decoration: BoxDecoration(
          color: showSearchField ? buttonColor : textColor,
          borderRadius: BorderRadius.circular(showSearchField ? 10 : 20),
          border: Border.all(color: Colors.black26),
        ),
        padding: EdgeInsets.symmetric(horizontal: showSearchField ? 6 : 0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SizeTransition(
              axis: Axis.horizontal,
              sizeFactor: animation,
              child: child,
            ),
          ),
          child: showSearchField
              ? _buildSearchField(key: const ValueKey(1))
              : _buildSearchButton(key: const ValueKey(2)),
        ),
      ),
    );
  }

  Widget _buildSearchButton({Key? key}) {
    return Center(
      child: IconButton(
        key: key,
        iconSize: 20,
        constraints: const BoxConstraints(), // Remove default constraints
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.search, color: buttonColor),
        onPressed: () => _toggleSearch(true),
      ),
    );
  }

  Widget _buildSearchField({Key? key}) {
    return Center(
      child: Row(
        key: key,
        mainAxisSize: MainAxisSize.min, // Prevent row from expanding unnecessarily
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: widget.onChanged,
              style: const TextStyle(color: textColor, fontSize: 14),
              cursorColor: textColor,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            iconSize: 20,
            constraints: const BoxConstraints(), // Remove default constraints
            padding: const EdgeInsets.all(4),
            icon: const Icon(Icons.close, color: textColor),
            onPressed: () {
              _toggleSearch(false);
              _controller.clear();
              widget.onChanged('');
            },
          ),
        ],
      ),
    );
  }
}