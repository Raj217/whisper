import 'package:flutter/material.dart';
import 'filter_section.dart';

class FilterOverlay extends StatefulWidget {
  final bool isMenuOpen;
  final Widget child;
  final List<FilterSection> sections;
  const FilterOverlay({
    super.key,
    this.isMenuOpen = false,
    required this.child,
    this.sections = const [],
  });

  @override
  State<FilterOverlay> createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Widget overlay = AnimatedContainer(
      duration: kThemeChangeDuration,
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: widget.isMenuOpen
            ? Colors.black.withOpacity(0.7)
            : Colors.transparent,
      ),
    );
    return Stack(
      children: [
        widget.child,
        widget.isMenuOpen ? overlay : IgnorePointer(child: overlay)
      ],
    );
  }
}
